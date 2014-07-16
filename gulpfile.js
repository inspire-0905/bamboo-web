var path = require('path'),
    gulp = require('gulp'),
    gutil = require('gulp-util'),
    connect = require('gulp-connect'),
    clean = require('gulp-clean'),
    coffee = require('gulp-coffee'),
    less = require('gulp-less');

var compile = function(file) {
    var compileFunc = function(file, method, outpath) {
        gulp.src(file)
            .pipe(method().on('error', function(err) {
                console.error(err.stack);
            }))
            .pipe(gulp.dest(outpath || 'src'));
    };
    if (!file) {
        compileFunc('src/**/*.coffee', coffee);
        compileFunc('src/**/*.less', less);
    } else {
        var extName = path.extname(file);
        compileFunc(file, (extName === '.coffee' ? coffee : less), path.dirname(file));
    }
};

gulp.task('clean', function () {
    gulp.src(['src/**/*.js', 'src/**/*.css'], {
        read: false
    }).pipe(clean());
});

gulp.task('compile', function () {
    compile();
});

gulp.task('connect', function() {
    connect.server({
        port: '8000',
        root: 'src',
        livereload: true
    });
});

gulp.task('watch', function () {
    gulp.watch(['src/**/*.html', 'src/**/*.coffee', 'src/**/*.less'], function(data) {
        console.info(data.type + ': ' + data.path);
        compile(data.path);
        gulp.src(data.path)
            .pipe(connect.reload());
    });
});

gulp.task('default', ['clean', 'compile', 'connect', 'watch']);
gulp.task('release', ['clean', 'compile']);