var path = require('path'),
    gulp = require('gulp'),
    gutil = require('gulp-util'),
    connect = require('gulp-connect'),
    clean = require('gulp-clean'),
    coffee = require('gulp-coffee'),
    less = require('gulp-less'),
    defineModule = require('gulp-define-module'),
    handlebars = require('gulp-handlebars'),
    modRewrite = require('connect-modrewrite');

var compile = function(file) {
    var compileFunc = function(file, method, outpath) {
        if (method === 'template') {
            gulp.src(file)
                .pipe(handlebars())
                .pipe(defineModule('plain', {
                    wrapper: 'define([], function() {return <%= handlebars %>});'
                }))
                .pipe(gulp.dest(outpath));
        } else {
            gulp.src(file)
                .pipe(method().on('error', function(err) {
                    console.error(err.stack);
                }))
                .pipe(gulp.dest(outpath || 'src'));
        }
    };
    if (!file) {
        compileFunc('src/**/*.coffee', coffee);
        compileFunc('src/**/*.less', less);
        compileFunc('src/js/module/**/template.html', 'template', 'src/js/module');
    } else {
        var extName = path.extname(file);
        var baseName = path.basename(file);
        if (extName === '.coffee' || extName === '.less') {
            compileFunc(file, (extName === '.coffee' ? coffee : less), path.dirname(file));
        } else if (baseName === 'template.html') {
            compileFunc(file, 'template', path.dirname(file));
        }
    }
};

gulp.task('clean', function() {
    return gulp.src(['src/**/*.js', '!src/js/vender/**/*.js', 'src/**/*.css', '!src/js/vender/**/*.css'], {
        read: false
    }).pipe(clean({force: true}));
});

gulp.task('compile', ['clean'], function() {
    compile();
});

gulp.task('connect', function() {
    connect.server({
        port: '8000',
        root: 'src',
        livereload: true,
        middleware: function() {
            return [
                modRewrite([
                    '^/[A-Za-z]+$ /index.html'
                ])
            ]
        }
    });
});

gulp.task('watch', function() {
    gulp.watch(['src/**/*.html', 'src/**/*.coffee', 'src/**/*.less', 'src/**/*.js', 'src/**/*.css'], function(data) {
        console.info(data.type + ': ' + data.path);
        compile(data.path);
        gulp.src(data.path)
            .pipe(connect.reload());
    });
});

gulp.task('default', ['compile', 'connect', 'watch']);
gulp.task('release', ['compile']);