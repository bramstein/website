module.exports = function(grunt) {

  // 1. All configuration goes here
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
            title: "bramstein.com"
          },
          plugins: {
            "metalsmith-markdown": {
              smartypants: true
            },
            "metalsmith-headings-identifier": {
            },
            "metalsmith-layouts": {
              engine: "handlebars"
            },
            "metalsmith-hyphenate": {
              elements: ["p", "a"]
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
            src: ['**/*.gz'],
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
      dist: 'mkdir -p dist && ./node_modules/.bin/buildProduction --inlinehtmlstyle 16384 --optimizeimages --gzip --outroot dist --root build'
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
