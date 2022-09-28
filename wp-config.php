<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'sPDt9XwnNpEUHqTNzqhr3rVdh4kx3pxL' );

/** Database hostname */
define( 'DB_HOST', 'wordpress.c9mf6n4szipl.us-east-1.rds.amazonaws.com' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'tZ7QW5^bRXNh@,D5AqQHynwb]9_j%:b9;Nwf(cW-p_8>nGYIQ-2?8(+Y$zfp!,wM');
define('SECURE_AUTH_KEY',  '>L^F~3@1t^j+B8?P*Emyz*j8oNP6=bi/$DIHBtAM}l8+p_MXKe/C:d%Ofb0C|8fX');
define('LOGGED_IN_KEY',    '~EYo6uPk*d6xmzId)1sq/67v<i-Js=JgT2y4aZIqBEk1:Sm2o]+sp~*;!43X+Xno');
define('NONCE_KEY',        '|Z -GzT2uwyS[&A8Ab]zY]F,@=o?4;IO-VDy#8-21Hx&$Esk/AQWCnW}11,V5L<7');
define('AUTH_SALT',        'RW1le_$Zyrb6|,#l/|@5$79ERi+lFE2QNtIc(oO-9iYFU:8V4Xfz/37I1&3}rmU ');
define('SECURE_AUTH_SALT', 'bp#Ini*T+#sWUdC72.^:Y<;=]sN0TdP`S@ {8043FEj:]_=Q}?4->~W+A:=<Q=0n');
define('LOGGED_IN_SALT',   '+Hupn%icYStUdQJhc6TG%A7Y#viCPsUej20YG|/HKDt;}tQtfLca0/(-X|<MT~k0');
define('NONCE_SALT',       '-D-69_bp|b/:CyJw0ZsE|V+z/oP9l9~20+/^RY[{2cq~oc[cgIXM-q<1,,C3 U%!');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */

define('FS_METHOD','direct');

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
