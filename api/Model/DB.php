<?php
require_once 'medoo.min.php';
class DB {
	private static $conn;
	
	public static function getConnection($type){
		if(!isset(self::$conn)){
			if($type == 'medoo'){
				self::$conn = new medoo([
					'database_type' => 'mysql',
					'database_name' => 'rest_api_demo',
					'server' => 'localhost',
					'username' => 'root',
					'password' => 'multi@media2',
					'charset' => 'utf8'
				]);
			}else{
				self::$conn = new PDO('mysql:host=localhost;dbname=rest_api_demo',
  				'root',
  				'multi@media2',
  				array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
				
			}
		}

		return self::$conn;
	}


	public static  function disconnect(){
		if(isset(self::$conn)){
			self::$conn->close();
		}
	}

}

?>