const gulp = require('gulp');
const concat = require('gulp-concat');
const terser = require('gulp-terser');

gulp.task('styles', function() {
	return gulp
		.src(['node_modules/bootstrap/dist/css/bootstrap.min.css'])
		.pipe(concat('app.min.css'))
		.pipe(gulp.dest('libs'));
});

gulp.task('scripts', function() {
	return gulp
		.src([
			'node_modules/@popperjs/core/dist/umd/popper.js',
			'node_modules/bootstrap/dist/js/bootstrap.js',
			'js/main.js'
		])
		.pipe(concat('app.js'))
		.pipe(gulp.dest('libs'));
});

gulp.task('compress', function() {
	return gulp
		.src('libs/app.js')
		.pipe(terser())
		.pipe(concat('app.min.js'))
		.pipe(gulp.dest('libs'));
});

gulp.task('build', gulp.series('styles', 'scripts', 'compress'));

gulp.task('watch', function() {
	return gulp.watch('js/*.js', gulp.series('scripts', 'compress'));
});
