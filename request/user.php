<?php
if ( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "login" ){
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please enter email correctly.");
			echo outputError($error);die();
		}
		if ( !isset($_POST["password"]) || empty($_POST["password"]) ){
			$error = array("msg"=>"Please enter password correctly.");
			echo outputError($error);die();
		}
		if($user = selectDB('customers',"`email` LIKE '{$_POST["email"]}' AND `password` LIKE '".sha1($_POST["password"])."' ORDER BY `id` DESC")  ){
			if( $user[0]["status"] == 1 ){
				$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
				echo outputError($error);die();
			}elseif( $user[0]["status"] == 2 ){
				$error = array("msg"=>"No user with this email.");
				echo outputError($error);die();
			}else{
				$data = array("firebase"=>$_POST["firebase"], "deviceType" => $_POST["deviceType"]);
				if( updateDB('customers',$data,"`id` = '{$user[0]["id"]}'") ){
				}
				$response = array(
					'id'=>$user[0]["id"],
					'points'=>$user[0]["points"],
					'validity'=>$user[0]["validity"]
				);
				echo outputData($response);
			}
		}else{
			$error = array("msg"=>"Please enter user credintial correctly.");
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "forgetPassword" ){
		if ( !isset($_GET["email"]) || empty($_GET["email"]) ){
			$error = array("msg"=>"Please fill email");
			echo outputError($error);die();
		}
		if( selectDB('customers',"`email` LIKE '".$_GET["email"]."'") ){
			$random = rand(11111111,99999999);
			$random1 = sha1($random);
			updateDB('customers',array("password"=>$random1),"`email` LIKE '".$_GET["email"]."'");
			$curl = curl_init();
			curl_setopt_array($curl, array(
			  CURLOPT_URL => 'https://createid.link/api/v1/send/notify',
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 0,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'POST',
			  CURLOPT_POSTFIELDS => array(
				'site' => '- Petmart',
			  	'subject' => 'New Password',
				'body' => 'Your new password is: '.$random.'<br><br>(Note: Please change your passowrd as soon as you login in app.)',
				'from_email' => 'noreply@petmart.com',
				'to_email' => $_GET["email"]),
			));
			$response = curl_exec($curl);
			curl_close($curl);
			if( isset($_GET["lang"]) && strtolower($_GET["lang"]) == "ar" ){
				$msg = "تم إرسال كلمة مرور جديدة لبريدك الإلكتروني";
			}else{
				$msg = "A new password has been sent to your email.";
			}
			echo outputData(array('msg'=>$msg));
		}else{
			if( isset($_GET["lang"]) && strtolower($_GET["lang"]) == "ar" ){
				$msg = "هذا البريد الإلكتروني ليس مسجل لدينا، الرجاء إدخاله بشكل صحيح";
			}else{
				$msg = "This email is not registred on our app, please enter a correct one.";
			}
			$error = array("msg"=>$msg);
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "deleteUser" ){
		if ( !isset($_GET["userId"]) || empty($_GET["userId"]) ){
			$error = array("msg"=>"Please enter user id");
			echo outputError($error);die();
		}elseif( selectDB('customers',"`id` = '{$_GET["userId"]}'") ){
			updateDB('customers',array("status"=>"2"),"`id` = '{$_GET["userId"]}'");
			echo outputData(array('msg'=>"User account has been removed successfully."));
		}else{
			$error = array("msg"=>"user id is wrong, please check user id.");
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "changePassword" ){
		if ( !isset($_POST["oldPassword"]) || empty($_POST["oldPassword"]) ){
			$error = array("msg"=>"Please fill old password");
			echo outputError($error);die();
		}
		if ( !isset($_POST["newPassword"]) || empty($_POST["newPassword"]) ){
			$error = array("msg"=>"Please fill new password");
			echo outputError($error);die();
		}
		if ( !isset($_POST["confirmPassword"]) || empty($_POST["confirmPassword"]) ){
			$error = array("msg"=>"Please fill confirm password");
			echo outputError($error);die();
		}
		if( $_POST["confirmPassword"] != $_POST["newPassword"] ){
			$error = array("msg"=>"new and confirm passwords are not match. please enter them correctly");
			echo outputError($error);die();
		}
		$random = $_POST["newPassword"];
		$random1 = sha1($random);
		$oldPass = sha1($_POST["oldPassword"]);
		if ( selectDB('customers',"`id` = '{$_POST["id"]}' AND `password` = '{$oldPass}'") ){
			if( updateDB('customers',array("password"=>$random1),"`id` = '".$_POST["id"]."'") ){
				echo outputData(array('msg'=>"A new password has been set."));
			}else{
				$error = array("msg"=>"An error happened please try again later..");
				echo outputError($error);die();
			}
		}else{
			$error = array("msg"=>"Old password is not a match");
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "profile" ){
		if ( $user = selectDB('customers',"`id` = '{$_POST["id"]}'") ){
			if( $getInterest = selectDB('interest',"`customerId` = '{$_POST["id"]}'") ){
				for( $i = 0 ; $i < sizeof($getInterest); $i++ ){
					$interests = selectDataDB("`id`, `enTitle`, `arTitle` ",'categories',"`id` = '{$getInterest[$i]["categoryId"]}'");
					$interest[] = $interests[0];
				}
			}
			if( isset($_GET["update"]) && $_GET["update"] == 1 ){
				if ( !isset($_POST["name"]) || empty($_POST["name"]) ){
					$error = array("msg"=>"Please enter name");
					echo outputError($error);die();
				}
				if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
					$error = array("msg"=>"Please fill email");
					echo outputError($error);die();
				}
				if ( !isset($_POST["mobile"]) || empty($_POST["mobile"]) ){
					$error = array("msg"=>"Please fill your mobile number.");
					echo outputError($error);die();
				}
				if( isset($_FILES['image']) AND is_uploaded_file($_FILES['image']['tmp_name']) ){
					$ext = end((explode(".", $_FILES['image']['name'])));
					$directory = "../admin/logos/";
					$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
					move_uploaded_file($_FILES['image']["tmp_name"], $originalfile);
					$imageData = str_replace("../admin/logos/",'',$originalfile);
				}else{
					$user = selectDB('customers',"`id` = '{$_POST["id"]}'");
					$imageData = $user[0]["logo"];
				}
				$data = array(
					'name'=>$_POST["name"],
					'email'=>$_POST["email"],
					'mobile'=>$_POST["mobile"],
					'logo'=>$imageData
				);
				if(updateDB('customers',$data,"`id` = '".$_POST["id"]."'")){
					$user = selectDB('customers',"`id` = '{$_POST["id"]}'");
					$response = array(
						'id'=>$user[0]["id"],
						'name'=>$user[0]["name"],
						'email'=>$user[0]["email"],
						'mobile'=>$user[0]["mobile"],
						'points'=>$user[0]["points"],
						'validity'=>$user[0]["validity"],
						'logo'=>$user[0]["logo"],
						'interest'=>$interest
					);
					echo outputData($response); die();
				}else{
					$error = array("msg"=>"An error happened please try again later..");
					echo outputError($error);die();
				}
			}else{
				$response = array(
					'id'=>$user[0]["id"],
					'name'=>$user[0]["name"],
					'email'=>$user[0]["email"],
					'mobile'=>$user[0]["mobile"],
					'points'=>$user[0]["points"],
					'validity'=>$user[0]["validity"],
					'logo'=>$user[0]["logo"],
					'interest'=>$interest
				);
				echo outputData($response);
			}
		}else{
			$error = array("msg"=>"no user with this id.");
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "register" ){
		if ( !isset($_POST["name"]) || empty($_POST["name"]) ){
			$error = array("msg"=>"Please enter name");
			echo outputError($error);die();
		}
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please fill email");
			echo outputError($error);die();
		}
		if ( !isset($_POST["password"]) || empty($_POST["password"]) ){
			$error = array("msg"=>"Please fill password");
			echo outputError($error);die();
		}
		if ( !isset($_POST["confirmPassword"]) || empty($_POST["confirmPassword"]) ){
			$error = array("msg"=>"Please fill confirm password");
			echo outputError($error);die();
		}
		if ( $_POST["password"] != $_POST["confirmPassword"] ){
			$error = array("msg"=>"Passwords does not match. Please try again.");
			echo outputError($error);die();
		}
		if ( !isset($_POST["mobile"]) || empty($_POST["mobile"]) ){
			$error = array("msg"=>"Please fill your mobile number.");
			echo outputError($error);die();
		}
		/*
		type 
		0 register,
		1 social,
		2 guest
		*/	
		$_GET["type"] = $_GET["userType"];	
		$_POST["password"] = sha1($_POST["password"]);		
		unset($_POST["confirmPassword"]);
		unset($_POST["action"]);
		unset($_POST["userType"]);
		$data = $_POST;
		if( selectDB('customers',"`email` LIKE '{$_POST["email"]}' AND `status` != '2'") ){
			$error = array("msg"=>"A user with this email is already registred.");
			echo outputError($error);die();
		}
		if( selectDB('customers',"`mobile` LIKE '{$_POST["mobile"]}' AND `status` != '2'") ){
			$error = array("msg"=>"A user with this mobile is already registred.");
			echo outputError($error);die();
		}
		if( insertDB('customers',$data) ){
			if ( $user = selectDB('customers',"`email` LIKE '{$_POST["email"]}' AND `password` LIKE '{$_POST["password"]}' ORDER BY `id` DESC") ){
				if( $user[0]["status"] == 1 ){
					$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
					echo outputError($error);die();
				}
				$response = array(
					'id'=>$user[0]["id"],
					'points'=>$user[0]["points"],
					'validity'=>$user[0]["validity"]
				);
				echo outputData($response);
			}
		}else{
			$error = array("msg"=>"Please enter registration data correctly.");
			echo outputError($error);die();
		}
	}else{
		$error = array("msg"=>"Please set type , 'login', 'register', 'forgetpassword'.");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please set type , 'login', 'register', 'forgetpassword'.");
	echo outputError($error);die();
}
?>