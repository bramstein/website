module.exports = function(grunt) {
  var cheerio = require('cheerio');

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: ['build', 'dist'],

    connect: {
      server: {
        options: {
          base: 'build',
          port: 3000,
          livereload: false,
          hostname: '*',
        }
      }
    },

    metalsmith: {
      build: {
        src: 'src',
        dest: 'build',
        options: {
          metadata: {
            title: "bramstein.com",
            site: {
              description: "Updates from the personal website of Bram Stein, a web developer.",
              title: "bramstein.com news",
              url: "https://www.bramstein.com/"
            }
          },
          plugins: {
           "metalsmith-collections": {
              news: {
                reverse: true,
                sortBy: "date"
              }
            },
            "metalsmith-markdown": {
              smartypants: true
            },
            "metalsmith-each": function (file, filename) {
              var $ = cheerio.load(file.contents.toString());
              var text = "";

              $('h2, p:not(.subtitle), ul, li').each(function (i, el) {
                text += $(el).text();
              });

              file.excerpt = text.substr(0, 300).trim() + '…';
            },
            "metalsmith-headings-identifier": {
            },
            "metalsmith-templates": {
              engine: "handlebars"
            },
            "metalsmith-hyphenate": {
              elements: ["p", "a"]
            },
            "metalsmith-path": true,
            "metalsmith-feed": {
              collection: "news",
              limit: false
            }
          }
        }
      }
    },

    watch: {
      dev: {
        files: ['src/**/*'],
        tasks: ['metalsmith:build']
      }
    },

    aws_s3: {
      deploy: {
        options: {
          bucket: 'bramstein',
          gzipRename: 'ext'
        },
        files: [
          {
            cwd: 'dist',
            src: ['**/*.gz', '**/*.html'],
            exclude: ['**/*.html.gz'],
            dest: '/',
            expand: true,
            params: {
              CacheControl: 'max-age=600, public'
            }
          },
          {
            cwd: 'dist',
            src: ['static/**'],
            exclude: ['**/*.gz'],
            dest: '/',
            expand: true,
            params: {
              CacheControl: 'max-age=31536000, public'
            }
          },
          {
            cwd: 'dist',
            src: ['favicon.ico'],
            dest: '/',
            expand: true,
            params: {
              CacheControl: 'max-age=31536000, public'
            }
          }
        ]
      }
    },

    exec: {
      dist: 'mkdir -p dist && ./node_modules/.bin/buildProduction --inlinehtmlstyle 16384 --optimizeimages --gzip --outroot dist --root build build/index.html build/writing/index.html build/speaking/index.html build/working/index.html'
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-exec');
  grunt.loadNpmTasks('grunt-metalsmith');
  grunt.loadNpmTasks('grunt-aws-s3');

  grunt.registerTask('default', ['metalsmith:build']);
  grunt.registerTask('dev', ['default', 'connect', 'watch']);
  grunt.registerTask('dist', ['clean', 'default', 'exec:dist']);
  grunt.registerTask('deploy', ['dist', 'aws_s3']);
};
