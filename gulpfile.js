var gulp = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('site', function() {
  gulp.src('_site/*.*')
    .pipe(livereload());
});

gulp.task('watch', function() {
  livereload.listen();
  gulp.watch('_site/*.*', ['site']);
});

