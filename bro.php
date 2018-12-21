<?php
/*
	Coded By Muhammad Zakir Ramadhan (c)
	Bot CLI Versi 1.2 
	Indonesian Coders
	Jangan Ngaku Recode Kalau Cuman Ubah Nama :)
*/
error_reporting(0);
$SET = array();
$SET['token'] = "EAAAAAYsX7TsBAFc4sgUGxUb7xqqdOLg6ysKSZCVz6NGGmNvfNpWhPdi2wyOQK7cmSa9iLZBEOCWJZBzFPrdb86ZBVR34f6C6qxy2jS9odfseAT4Ni4zxSIvrMszQIYGdT04wos9c4nZBAxVOhjIyobtwjrC9WqICAmwY6lxjfgIvP71lOZCiLJuG8seFTcW9QgLPrEeAat0gSBeIonePUI";
$SET['limit'] = "100";
$SET['react'] = 1; /* 0 LIKE | 1 LOVE | 2 HAHA | 3 WOW | 4 SAD | 5 ANGRY */
$SET['delay'] = 5;
$SET['ulang'] = true;
$SET['bot_komen'] = false; /* true bot aktif dan false bot mati */
$SET['grab_token'] = true; /* true untuk aktif dan false untuk mati */
$SET['bomb_react'] = false;
$komennya = array("Hai @nama@!\nJika dalam cinta kau mainkan sebuah drama, kelak kau harus siap untuk menjadi pemeran utama dalam sebuah karma.\n-bot","@nama@ Tatapanmu memanglah sederhana, namun dapat mengalihkan dunia.\n-bot","Jika rindu ibarat uang, mungkin aku sudah menjadi orang terkaya di dunia karena telah menanggung rindu padamu.\n-bot","@nama@ Aku dan kamu bagaikan ambulan tanpa wiu uiwu xixixixi \n-bot"); /* Setting Di Sini Kata2nya */
banner();
version();
echo " Memeriksa Token Anda......\n";
if(cek_token()==1){
sleep(1);
echo " Token Hidup! Bot Beraksi..............\n";
$me = me();
echo " Welcome  ".utf8_decode($me['name'])." [ ".$me['id']." ] \n";
if($SET['ulang'] == true){
	while (true) {
		gass();
		sleep($SET['delay']);
	}
} else {
	gass();
}
} else {
	echo " Token Anda Mati! Apakah Anda Mau Generate Token Baru? (y/n) :";
	if($SET['grab_token']==true){
	$y = trim(fgets(STDIN));
	if($y == "y" or $y == "Y"){
		$token = grabtoken();
		echo " Token Anda Adalah -> ".$token."\n";
		exit();
	} else {
		echo " Good Bye! Thanks For Using My Tools!\n By ZakirDotID\n";
		exit();
	}
	} else {
		echo " Good Bye! Thanks For Using My Tools!\n By ZakirDotID\n";
		exit();
	}
}
function gass(){
	global $SET,$komennya;
	$status = getStatus();
	$reaksi = array("LIKE","LOVE","HAHA","WOW","SAD","ANGRY");
	$react_type = $reaksi[$SET['react']];
	echo " Total Thread ( ".count($status['data'])." )\n";
	sleep($SET['delay']);
	foreach ($status['data'] as $key => $data) {
		$id_post = $data['id'];
		$from = utf8_decode($data['from']['name']);
		$type = $data['type'];
		$token = $SET['token'];
		$ids = explode("_", $id_post);
		$ids = $ids[1];
		echo " [{$ids}] React {$react_type} Status Si {$from} ";
		sleep($SET['delay']);
		$url = "https://graph.facebook.com/v2.11/{$id_post}/reactions?";
		$post = "type={$react_type}&access_token={$token}&method=post";
		$respon = _curl($url,$post);
		$result = json_decode($respon,true);
		if($result['success']){
			echo " Sukses ";
			if($SET['bot_komen'] == true){
				$kata = $komennya[array_rand($komennya)];
				$kata = str_replace("@nama@", $from, $kata);
				$kata = $kata."\n";
				$kata = urlencode($kata);
				$kirim_kata = file_get_contents("https://api.facebook.com/method/stream.addComment?post_id={$id_post}&comment={$kata}&access_token={$token}");
				if(preg_match("/stream_addComment_response/", $kirim_kata)){
					echo " ( Sukses Komen ) :p\n";
				} else {
					echo " ( Gagal Komen ) :(\n";
				}
			} else {
				echo "\n";
			}
			
		} else {
			echo " Gagal\n";
		}
		sleep(5);
	}
}
function grabtoken(){
	echo " Input Username : ";
	$username = trim(fgets(STDIN));
	echo " Input Password : ";
	$password = trim(fgets(STDIN));
	echo " Mengirim Repond Ke server....\n";
	$url = "https://getliker.net/login/gettoken.php";
	$data = "u={$username}&p={$password}";
	$respond = _curl($url,$data);
	preg_match("/src=\"(.*)\"/", $respond , $token);
	$get = json_decode(file_get_contents($token[1]),true);
	return $get['access_token'];
}
function cek_token(){
	global $SET;
	$token = $SET['token'];
	$respond = json_decode(file_get_contents("https://graph.facebook.com/me?access_token={$token}&fields=name,id"),true);
	if($respond['name']){
		return 1;
	} else {
		return 0;
	}
}
function getStatus()
{
	global $SET;
	return json_decode(file_get_contents("https://graph.facebook.com/v2.1/me/home?fields=id,from,type,message&limit=".$SET['limit']."&access_token=".$SET['token']),true);
}
function _curl($url,$data)
{
	$curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_CONNECTTIMEOUT,20);
    curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31');
    curl_setopt($curl, CURLOPT_COOKIE,'cookie.txt');
    curl_setopt($curl, CURLOPT_COOKIEFILE,'cookie.txt');
    curl_setopt($curl, CURLOPT_COOKIEJAR,'cookie.txt');
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 3);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($curl,CURLOPT_FOLLOWLOCATION,true);
    $result = curl_exec($curl);
    if(!$result){
    	echo "Retry 5s....\n";sleep(5);
    }
    return $result;
    curl_close($curl);
}
function me(){
	global $SET;
	return json_decode(file_get_contents("https://graph.facebook.com/v2.1/me?access_token=".$SET['token']),true);
}
function banner(){
echo "
 ------------------------------------------------------------------------------
     ___                  __             __ __           __            __
    /   |  _______  __   / /   ____     / //_/__  ____  / /_____  ____/ /
   / /| | / ___/ / / /  / /   / __ \   / ,< / _ \/ __ \/ __/ __ \/ __  / 
  / ___ |(__  ) /_/ /  / /___/ /_/ /  / /| /  __/ / / / /_/ /_/ / /_/ /  
 /_/  |_/____/\__,_/  /_____/\____/  /_/ |_\___/_/ /_/\__/\____/\__,_/   

 ------------------------------------------------------------------------------
 --------------------------[ Powered By ZakirDotID ]---------------------------
 ";
}
function version(){
	if (!file_exists("bot_zakir.version")) {
		$data = "Bot Zakir V.1.3\r\nHak Cipta!";
		@file_put_contents("bot_zakir.version", $data);
		return 0;
	} else {
		$get = file_get_contents("bot_zakir.version");
		preg_match("/Bot Version (.*)/", $get , $r);
		echo "Bot Version ".$r[1]. "\n";
	}
}