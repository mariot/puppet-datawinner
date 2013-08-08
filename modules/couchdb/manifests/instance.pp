class couchdb::instance (
$service_name="couchdb", 
$erl_max_ports="2048", 
$bind_address="0.0.0.0",
$port="5984", 
$timeout="43200",
$username="admin", 
$password="admin",
$max_dbs_open="1000",
$os_process_timeout="240000",
$database_dir="/opt/apache-couchdb/var/lib/couchdb"
) {
     file { "/etc/init.d/${service_name}" :
	owner => 'root',
	group => 'root',
	mode => '0555',
     	content => template('couchdb/etc/init.d/couchdb_template.erb'),
     }
     
     file { "/opt/apache-couchdb/etc/default/${serivce_name}":
     	owner => 'couchdb',
	group => 'couchdb',
	mode => '0444',
	content => template('couchdb/opt/apache-couchdb/etc/default/couchdb_template.erb'),
     }     

     $couchdb_options = "-a /opt/apache-couchdb/etc/default/${serivce_name} -p /opt/apache-couchdb/var/run/couchdb/${service_name}.pid"
     $log_file = "/opt/apache-couchdb/var/log/${service_name}.log"
     $view_index_dir=$database_dir	
     
     file { "${database_dir}":
	ensure => directory,
	owner => 'couchdb',
	group => 'couchdb',
     }	

     file {"/opt/apache-couchdb/etc/couchdb/${service_name}.ini":
     	owner => 'couchdb',
	group => 'couchdb',
	mode => '0444',
	content => template('couchdb/opt/apache-couchdb/etc/couchdb/local_ini_template.erb'),
     }
}