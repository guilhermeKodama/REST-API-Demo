<?php
class BetDAO {
		
	function save ($bet) {
		$conn = DB::getConnection('pdo');
		$conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING );
		$stmt = $conn->prepare("INSERT INTO bet (`winner`,`value`,`finalization`, `round`, `user_id`, `fight_id`,`is_draw`) VALUES (:winner,:value,:finalization,:round,:user_id,:fight_id,:is_draw)");
		$stmt->bindParam("winner", $bet->winner);
		$stmt->bindParam("value", $bet->value);
  		$stmt->bindParam("finalization", $bet->finalization);
		$stmt->bindParam("round", $bet->round);
		$stmt->bindParam("user_id", $bet->user_id);
		$stmt->bindParam("fight_id", $bet->fight_id);
		$stmt->bindParam("is_draw", $bet->is_draw,PDO::PARAM_BOOL);
  		$stmt->execute();
	}
}
