

/**
*
* Allow local URL and non-standard ports to be used in webhooks
*/
add_filter( 'http_request_args', function( $args ) {
  $args['reject_unsafe_urls'] = false;
  return $args;
});