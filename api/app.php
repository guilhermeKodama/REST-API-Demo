<?php
date_default_timezone_set('America/Manaus');

/* FORCAR MOSTRAR ERROS */
ini_set ( 'display_errors', 1 );
ini_set ( 'display_startup_erros', 1 );
error_reporting ( E_ALL );

/* DEPENDENCIES */
require '../api/Model/DB.php';
require '../api/Model/ProductDAO.php';
require '../Slim/Slim/Slim.php';


\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim(array( 'debug' => true));

$app->response()->header('Content-Type', 'application/json;charset=utf-8');

$app->get('/', function () {
	echo "Hello";
});

$app->get('/product', function () {
	$productDAO = new ProductDAO();
	$products = $productDAO->get();
  	echo '{"products":'.json_encode($products).'}';
});

$app->post('/product', function () {
	$request = \Slim\Slim::getInstance()->request();
	$product = json_decode($request->getBody());
	$productDAO = new ProductDAO();
	$productDAO->insert($product);
  	echo '{"result":"ok"}';
});

$app->put('/product', function () {
	$request = \Slim\Slim::getInstance()->request();
	$product = json_decode($request->getBody());
	$productDAO = new ProductDAO();
	$productDAO->update($product);
  	echo '{"result":"ok"}';
});

$app->delete('/product', function () {
	$request = \Slim\Slim::getInstance()->request();
	$product = json_decode($request->getBody());
	$productDAO = new ProductDAO();
	$productDAO->delete($product);
  	echo '{"result":"ok"}';
});

$app->run();

