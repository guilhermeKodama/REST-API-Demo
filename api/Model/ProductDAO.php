<?php

class ProductDAO {

	function get(){
		$db = DB::getConnection('medoo');
		$products = $db->select("product", "*");
		return $products;
	}

	function insert($product){
		$db = DB::getConnection('medoo');
		$last_user_id = $db->insert("product", [
		"name" => $product->name
		]);
	}

	function update($product){
		$db = DB::getConnection('medoo');
		$db->update("product", [
			"name" => $product->name
			],[
			"id"=>$product->id
		]);
	}
	
	function delete($product){
		$db = DB::getConnection('medoo');
		$db->delete("product",[
			"id"=>$product->id
		]);
	}
}