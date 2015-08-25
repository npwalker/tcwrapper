class tcwrapper (
  $max_heap = '1024m',
  $min_heap = '256k',
  $additional_java_args = undef 
){

  $static_config = [ '-XX:+HeapDumpOnOutOfMemoryError',
                     '-XX:MaxPermSize=256m',
                     '-Dspring.profiles.active=dev',
                     '-DruntimeEnvironment=dev',
                     '-XX:+CMSClassUnloadingEnabled',
                     '-XX:+CMSPermGenSweepingEnabled' ]
   
  if ( empty($additional_java_args) ) {
    $final_java_args = concat( $static_config, "-Xmx${max_heap}", "-Xss${min_heap}" )
  } else {
    $final_java_args = concat( $static_config, "-Xmx${max_heap}", "-Xss${min_heap}", $additional_java_args )
  }
  notify { "test = ${final_java_args}" :}

  file { '/tmp/wrapper.conf' :
    ensure => file,
    content => template('tcwrapper/wrapper.conf.erb'),
  }

}
