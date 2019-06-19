

/**
*
* Allow local URL and non-standard ports to be used in webhooks
*/
add_filter( 'http_request_args', function( $args ) {
  $args['reject_unsafe_urls'] = false;
  return $args;
});

/**
*
* Add custom meta to WooCommerce order payload
*/
add_action( 'woocommerce_new_order_item', 'tp_add_custom_meta_to_order', 99, 3);
function tp_add_custom_meta_to_order( $item_id, $item, $order_id ) {
  wc_add_order_item_meta($item_id, 'Programs', $item->get_name() );
  wc_add_order_item_meta($item_id, 'firstname', 'AA' );
  wc_add_order_item_meta($item_id, 'lastname', 'BB' );
  wc_add_order_item_meta($item_id, 'email', 'e@ma.il' );
}