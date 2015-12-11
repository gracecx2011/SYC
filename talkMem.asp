@@ -0,0 +1,1334 @@
<%response.buffer = True%>
<%response.Expires = 0%>
<%response.contenttype="text/HTML"%>
<%session("strPage") = "/member/talk"%>
<!--#include virtual="/asp/universal.asp"-->
<%
	If request("do") = "" Or request("do") = "recent" Then
		intRecent = True
	Else
		intRecent = False
	End If
	If request("do") = "popular" Then
		intPopular = True
	Else
		intPopular = False
	End If
	If request("do") = "follow" Then
		intFollow = True
	Else
		intFollow = False
	End If
	If request("name") <> "" Then
		strHandle = request("name")	
		intSearch = True
	Else
		intSearch = False
		strHandle = ""
	End If
	If request("tag") <> "" Then
		strTag = request("tag")
		intag = True
	Else
		strTag = ""
		intag = False
	End If
	If request("do") = "mine" Then
		intMine = True
	Else
		intMine = False
	End If
	'ascii of first character
	Dim intTag(122)
	For intX = 1 To 122
		intTag(intX) = False
	Next
%>

<!DOCTYPE html>
<html>
<head>
		<!-- Meta Tags -->
		<meta charset="utf-8">
		<meta name="description" content="ShrinkYourself">
        <meta name="viewport" content="width=device-width" />

		<!-- Title -->
		<title>ShrinkYourself</title>

		<!-- Google Fonts -->
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>

		<!-- Favicon -->
		<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
		<link href="/member/css/stylere.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="/member/css/talk.css">
        <link rel="canonical" href="http://shrinkyourself.com/"/>
		<!-- Stylesheets -->
		<link href="/member/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="/member/css/fontello.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		<link href="/member/css/style.css" rel="stylesheet" type="text/css">
		<link href="/member/css/member-footer.css" rel="stylesheet" type="text/css">
		<link href="/member/css/popModal.css" rel="stylesheet" type="text/css">
		<link href="/public/css/public-read.css" rel="stylesheet" type="text/css">
		<link href="/member/css/readcss.css" rel="stylesheet" type="text/css">
		<link href="/member/css/owl.carousel2.css" rel="stylesheet">

		<link href="/public/css/fontello.css" rel="stylesheet" type="text/css">
		<link href="/public/css/style.css" rel="stylesheet" type="text/css">

		<!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<link href="css/jackbox-ie8.css" rel="stylesheet" type="text/css" />
			<link rel="stylesheet" href="css/ie.css">
        <![endif]-->

		<!--[if gt IE 8]>
			<link href="css/jackbox-ie9.css" rel="stylesheet" type="text/css" />
		<![endif]-->

		<!--[if IE 7]>
			<link rel="stylesheet" href="css/fontello-ie7.css">
		<![endif]-->

		<style type="text/css">
			.no-fouc {display:none;}
			a:hover{
				color:white;
				text-decoration:none;
			}
			a:link{
				color:white;
				text-decoration:none;
			}
			a:visited{
				color:white;
				text-decoration:none;
			}
			a.myLink:hover{
				color:#ED018A;
				text-decoration:none;
			}
			a.myLink:link{
				color:#ED018A;
				text-decoration:none;
			}
			a.myLink:visited{
				color:#ED018A;
				text-decoration:none;
			}
			.hidereply{
				float: left;
				border: 1px solid #8C3EAC;
				border-radius: 5px;
				background-color: #8C3EAC;
				color: white;
				padding: 4px 6px;
				margin-top: 15px;
				cursor:pointer
			}
			.replypost,.replymypost{
				font-size:20px;height:40px;width:150px;float:right;display:inline-block; background-color:#01BF2F;color:#ffffff;
				margin-top: 10px;display:block;cursor: pointer;border-radius:5px;height: 35px;padding-top: 5px;padding-left: 53px;
			}
			.rpostbutton{
				pointer-events: none;
			   cursor: default;
			   opacity:.65
			}
			input[type="checkbox"]+label:before{
				border-radius:5px !important
			}
			
			.search-button{
				color:#01bf2f !important;
				background-color:white !important;
				border:1px solid #01bf2f
			}
		</style>
		<style type="text/css">
			html {
			  height: 100%;
			  box-sizing: border-box;
			}
			*,
			*:before,
			*:after {
			  box-sizing: inherit;
			}
			body {
			  position: relative;
			  margin: 0;
			  min-height: 100%;
			  font-family: "Helvetica Neue", Arial, sans-serif;
			}
			.demo {
			  margin: 0 auto;
			  padding-top: 64px;
			  max-width: 640px;
			  width: 94%;
			}
			.demo h1 {
			  margin-top: 0;
			}
			.footer {
			  position: absolute;
			  right: 0;
			  bottom: 0;
			  left: 0;
			  background-color: #efefef;
			  text-align: center;
			}
		</style>


		<!-- jQuery -->
		<script src="<%=session("strCDN")%>/member/js/jquery-1.11.0.min.js"></script>
		<script src="<%=session("strCDN")%>/member/js/jquery-ui-1.10.4.min.js"></script>

		<!-- Preloader -->
		<script src="<%=session("strCDN")%>/member/js/jquery.queryloader2.min.js"></script>
		<script src="<%=session("strCDN")%>/member/js/popModal.js"></script>
		<script src="js/func_tags.js"></script>
		<script>
			function showPop() {
				$('.dialog_content').dialogModal({
					onOkBut: function() {
					},
					onLoad: function() {},
					onClose: function() {},
				});
			}
			function doAlert(arg){
				document.getElementById('pop').innerHTML = arg;
				document.getElementById("pop_header").innerHTML = "ShrinkYourself";
				showPop();
			}
			$('html').addClass('no-fouc');
			$(document).ready(function(){
				$('html').show();
				var window_w = $(window).width();
				var window_h = $(window).height();
				var window_s = $(window).scrollTop();
			});
			function openTagLetter(arg) {
				for (var i=97; i<123; i++){
					sLetter = String.fromCharCode(i)
					if (document.getElementById("tag-letter-" + sLetter)!=null) {
						document.getElementById("tag-letter-" + sLetter).style.display="none";
					}
				}
				document.getElementById(arg).style.display="block";
			}
			function openNameLetter(arg) {
				for (var i=97; i<123; i++){
					sLetter = String.fromCharCode(i)
					if (document.getElementById("name-letter-" + sLetter)!=null) {
						document.getElementById("name-letter-" + sLetter).style.display="none";
					}
				}
				document.getElementById(arg).style.display="block";
			}
			function toggleSearch() {
				if (document.getElementById("search").style.display == "block") {
					document.getElementById("search").style.display = "none";
				}else{
					document.getElementById("search").style.display = "block";
				}
			}	
		</script>
		<!--#include virtual="/js/timeout.js"-->
		<!--#include virtual="/js/tracking.js"-->
		<!--#include virtual="/member/js/tracking.js"-->
	</head>

<body class="sticky-header-on tablet-sticky-header" onload="startClock();">


<section id="content">
<div id="p-bg" style="  background: rgba(0,0,0,0.7);  position: fixed;top: 0; left: 0;right: 0;bottom: 0;display:none;z-index: 8888;overflow: auto;transition: all 200ms ease;"></div>
	<div id="dialog_content" class="dialog_content" style="display:none">
		<div class="dialogModal_header"><h2><label id="pop_header">ShrinkYourself</label></h2></div>
		<div class="dialogModal_content" id="pop"></div>
		<div class="dialogModal_footer">
			<button type="button" data-dialogModalBut="ok">Close</button>
		</div>
	</div>
<div class="container">
<!--#include virtual="/member/asp/header.asp"-->
<script>
	var keylis =new Array();
</script>
<% strSQL = "SELECT [Tag] FROM [dbo].tags" %>
<% Call OpenRecordset(1, strSQL, session("strPage"))%>
<% If Not objRst1.BOF And Not objRst1.EOF Then%>
	<% Do%>
		<script>
			keylis.unshift("<% =objRst1("Tag") %>");
		</script>
		<% objRst1.MoveNext%>
	<% Loop Until objRst1.EOF%>
<% End If%>

		<div class="section full-width-bg gray-bg"  >
			<div style="background-color:#C0C0C0; padding:30px 0 70px 0; width:100%;margin:0 auto;border-radius:5px;margin-bottom:35px;">
			<form style="width:95%;margin:0 auto; ">
				<textarea class="form-control commentbody" onkeyup="abled()" id="commentbody" rows="5" placeholder="What's on your mind? Post it here for only you to see or to share with the ShrinkYourself community."  style="border-radius: 5px;width:100%;max-width:100%;border:1px solid #DBDBDB"></textarea>
				<input class="commenttag" style="width:150px;float:left;display:inline-block;margin-top:25px;display:block;border-radius:5px;display:none;"  placeholder="tags">
				<div style="padding-left: 40px;margin-top: 5px;">
					<input id="5" type="checkbox" name="share" checked>
					<label for="5" class="user"><span class="ui-btn-text" style="color:white;">Share with the ShrinkYourself community</span>
				</div>
				<div type="submit" style="text-align:center;width:150px;float:right;display:inline-block; background-color:#01bf2f;color:#ffffff; margin-top:15px;display:block;cursor: pointer;border-radius:5px;font-size:20px;height:40px;padding-top:5px;text-transform: capitalize;" disabled="true" class="postcomment btn btn-default" >Post</div>
			</form>
			</div>
		<div style="clear:both;"></div>

		<div style="height: 30px; float: right;">
			<%If intFollow Then%>
				<span><a href="/member/talk.asp?do=follow" id="follow" style="border:1px solid rgb(59, 80, 247);background-color:rgb(59, 80, 247);border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Following</a></span>
				
			<%Else%>
				<span><a href="/member/talk.asp?do=follow" id="follow" style="background-color:white;color:rgb(135, 85, 255);border:1px solid rgb(59, 80, 247);border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Following</a></span>
				
			<%End If%>
			<%If intRecent Then%>
				<span><a href="/member/talk.asp?do=recent" id="latest" style="border:1px solid #ed018a;background-color:#ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Latest</a></span>
				
			<%Else%>
				<span><a href="/member/talk.asp?do=recent" id="latest" style="background-color:white;color:#ed018a;border:1px solid #ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Latest</a></span>
				
			<%End If%>
			<%If intSearch Then%>
				<span><a href="javascript:void(0)" onclick="toggleSearch()" id="Search" style="border:1px solid #01bf2f;background-color:#01bf2f;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Search</a></span>
				
			<%Else%>
				<span><a href="javascript:void(0)" onclick="toggleSearch()" id="Search" class="search-button" style="background-color:#01bf2f;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Search</a></span>
				
			<%End If%>
			<%If intPopular Then%>
				<span><a href="/member/talk.asp?do=popular" class="com popular" id="Popular" style="border:1px solid #8c3eac;background-color:#8c3eac;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Popular</a></span>
				
			<%Else%>
				<span><a href="/member/talk.asp?do=popular" class="com popular" id="Popular" style="background-color:white;color:#8c3eac;border:1px solid #8c3eac;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;">Popular</a></span>
				
			<% End If%>
			<%If intMine Then%>
				<span><a href="/member/talk.asp?do=mine" class="com post" id="mypost" style="border:1px solid rgb(147, 147, 147);border-radius:5px; background: rgb(147, 147, 147); padding:6px 10px;font-size:15px;padding-top: 5px;">My Post</a></span><br /><br />
			<%Else%>
				<span><a href="/member/talk.asp?do=mine" class="com post" id="mypost" style="border-radius:5px; background:white;color: rgb(147, 147, 147); border:1px solid rgb(147, 147, 147); padding:6px 10px;font-size:15px;padding-top: 5px;">My Post</a></span><br /><br />
			<%End If%>
		</div>
	<div id="search" style="display:none">
		Tags:&nbsp;
<% strSQL = "SELECT * FROM Comments WHERE Comments.del <> 0 AND Comments.ArticleId = -1 AND Comments.IsPublic = 1 AND ParentCommentId = -1 ORDER BY Date_Created ASC" %>
<% Call OpenRecordset(1, strSQL, session("strPage"))%>
<% If Not objRst1.BOF And Not objRst1.EOF Then%>
	<% Do%>
		<% strSQL = "SELECT Tag FROM Tags LEFT OUTER JOIN TagsComments on Tags.TagId = TagsComments.TagId WHERE TagsComments.CommentId = " & objRst1("CommentId")%>
		<% Call OpenRecordset(3, strSQL, session("strPage"))	%>
		<% If Not objRst3.BOF And Not objRst3.EOF Then%>
			<%strThisTag = LCase(Left(objRst3("Tag"),1))%>
<%' error on next line, so I added test for empty tag%>
			<%If strThisTag <> "" Then intTag(Asc(strThisTag)) = True%>

		<%End If%>
		<%objRst1.MoveNext%>
	<%Loop Until objRst1.EOF%>
<%End If%>
<%For intX = 97 To 122%>
	<%If intTag(intX) Then%>
		<a href="javascript:void(0)" onclick="openTagLetter('tag-letter-<%=Chr(intX)%>'); return false;" class="myLink"><%=UCase(Chr(intX))%>...</a>
	<%End If%>
<%Next%>
<%For intX = 97 To 122%>
	<%If intTag(intX) Then%>
		<%strSQL = "SELECT distinct(Tag) FROM Tags LEFT OUTER JOIN TagsComments on Tags.TagId = TagsComments.TagId left outer join Comments on Tags.TagId = TagsComments.TagId where Tag like '" & Chr(intX) & "%' and Comments.IsPublic = 1 and Comments.del = 0 and ParentCommentId = -1"%>
		<%Call OpenRecordset(1, strSQL, session("strPage"))%>
		<%If Not objRst1.BOF And Not objRst1.EOF Then%>
			<div id="tag-letter-<%=Chr(intX)%>" style="display:none; padding-left:40px;">
			<%Do%>
				>&nbsp;<a href="/member/talk.asp?tag=<%=server.URLencode(objRst1(0))%>" class="myLink"><%=LCase(objRst1(0))%></a><br />
				<%objRst1.MoveNext%>
			<%Loop Until objRst1.EOF%>
			</div>
		<%End If%>
	<%End If%>
<%Next%>
		<br /><br />
		Nicknames:&nbsp;
<%For intX = 97 To 122%>
	<%strSQL = "SELECT distinct(Handle) FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Users.Handle like '" & Chr(intX) & "%' and Comments.del <> 0 AND Comments.ArticleId = -1 AND ParentCommentId = -1 AND Comments.IsPublic = 1"%>
	<%Call OpenRecordset(1, strSQL, session("strPage"))%>
	<%If Not objRst1.BOF And Not objRst1.EOF Then%>
		<a href="javascript:void(0)" onclick="openNameLetter('name-letter-<%=Chr(intX)%>'); return false;" class="myLink"><%=UCase(Chr(intX))%>...</a>
	<%End If%>
<%Next%>
<%For intX = 97 To 122%>
	<%strSQL = "SELECT distinct(Handle) FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Users.Handle like '" & Chr(intX) & "%' and Comments.del <> 0 AND Comments.ArticleId = -1 AND ParentCommentId = -1 AND Comments.IsPublic = 1"%>
	<%Call OpenRecordset(1, strSQL, session("strPage"))%>
	<%If Not objRst1.BOF And Not objRst1.EOF Then%>
		<div id="name-letter-<%=Chr(intX)%>" style="display:none; padding-left:40px;">
		<%Do%>
			>&nbsp;<a href="/member/talk.asp?name=<%=objRst1(0)%>" class="myLink"><%=objRst1(0)%></a><br />
			<%objRst1.MoveNext%>
		<%Loop Until objRst1.EOF%>
		</div>
	<%End If%>
<%Next%>
	</div>
	</div>
<%intPopular = False%>
<%If strHandle <> "" Then%>
	<% strSQL = "SELECT [CommentId],[CommentText],[Date_Created],[Handle],Comments.MasterKey as [MasterKey],(select count(*) from [dbo].[Likes] where Likes.CommentId=Comments.CommentId) as Count_Of_Likes FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Users.Handle = '" & strHandle & "' and Comments.del <> 0 AND Comments.ArticleId = -1 AND Comments.IsPublic = 1 AND ParentCommentId = -1 ORDER BY Count_Of_Likes DESC,Date_Created ASC" %>
<%ElseIf intFollow Then%>
	<% strSQL = "select * from Comments_view where MasterKey in (select FollowID as MasterKey from User_Follow where MasterKey='" & session("lngMasterKey") & "')order by Comments_view.Date_Created desc" %>
<%ElseIf intRecent Then%>
	<% strSQL = "SELECT [CommentId],[CommentText],[Date_Created],[Handle],Comments.MasterKey as [MasterKey],(select count(*) from [dbo].[Likes] where Likes.CommentId=Comments.CommentId) as Count_Of_Likes FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del <> 0 AND Comments.ArticleId = -1 AND Comments.IsPublic = 1 AND ParentCommentId = -1 ORDER BY Date_Created DESC" %>
<%ElseIf intMine Then%>
	<%' strSQL = "SELECT [CommentId],[ParentCommentId],[CommentText],[Date_Created],[tags],[Handle],[IsPublic],(select count(*) from [dbo].[Likes] where Likes.CommentId=Comments.CommentId) as Count_Of_Likes FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del<>'false' AND Comments.MasterKey='" & session("lngMasterKey") & "' AND Comments.ArticleId='-1' ORDER BY Date_Created DESC" %>
	<% strSQL = "SELECT [CommentId],[ParentCommentId],[CommentText],[Date_Created],[tags],[Handle],[IsPublic],Comments.MasterKey as [MasterKey],(select count(*) from [dbo].[Likes] where Likes.CommentId=Comments.CommentId) as Count_Of_Likes FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del <> 0 AND Comments.MasterKey='" & session("lngMasterKey") & "' AND Comments.ArticleId='-1' AND ParentCommentId = -1 ORDER BY Date_Created DESC" %>
<%Else%>
	<% strSQL = "SELECT [CommentId],[CommentText],[Date_Created],[Handle],Comments.MasterKey as [MasterKey],(select count(*) from [dbo].[Likes] where Likes.CommentId=Comments.CommentId) as Count_Of_Likes FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del <> 0 AND Comments.ArticleId = -1 AND Comments.IsPublic = 1 AND ParentCommentId = -1 ORDER BY Count_Of_Likes DESC,Date_Created ASC" %>
	<%intPopular = True%>
<%End If%>
<% Call OpenRecordset(1, strSQL, session("strPage"))%>
<% If Not objRst1.BOF And Not objRst1.EOF Then%>
		<section class="section full-width-bg gray-bg popularcom" style="padding-top:1px;padding-bottom:45px">

	<%If strTag <> "" Then response.write("Tag: " & strTag & "<br /><br />")%>
	<%If strHandle <> "" Then response.write("Nickname: " & strHandle & "<br /><br />")%>

	<% Do%>
		<script>
			var tagsa=new Array();
		</script>



		<!-----------------Not intMine--------------->
		<!-----------------Not intMine--------------->
		<!-----------------Not intMine--------------->
		<%If Not intMine Then%>
			<%intTagFound = False%>
			<% strSQL = "SELECT Tag FROM Tags LEFT OUTER JOIN TagsComments on Tags.TagId = TagsComments.TagId WHERE TagsComments.CommentId = " & objRst1("CommentId")%>
			<% Call OpenRecordset(3, strSQL, session("strPage"))	%>
			<% If Not objRst3.BOF And Not objRst3.EOF Then%>
				<% Do%>
					<%If Trim(strTag) <> "" Then%>
						<%If LCase(strTag) = LCase(objRst3("Tag")) Then intTagFound = True%>
					<%Else%>
						<%intTagFound = True%>
					<%End If%>
					<script>
						tagsa.unshift("<% =objRst3("Tag") %>");
					</script>
					<% objRst3.MoveNext%>
				<% Loop Until objRst3.EOF%>
			<% End If%>
			<%If intTagFound Then%>
				<div class="comboli" style="background-color:#FFF;width:100%; margin:5px auto;display:block; border-style: solid;border-width: 1px; border-color:#DBDBDB; padding:20px;height:auto;border-radius: 5px;display:none;">
					<!------------OCT23-------------->
					<div id="titlee" style="height:25px">
						<div id="handle" style="font-size:16px;color: #ff6446;font-weight:700;float: left; margin-right: 5px;"><% =objRst1("Handle") %></div>
						<div id="time" style="color:#B9B9B9;font-size:16px;float:left"><% =objRst1("Date_Created") %></div>
						<!-----------------Edit Post------------------>
						<% st=objRst1("Handle")%>
						<% st2=session("strHandle")%>
						<% If st=st2 Then%>
							<div class="edit-buttonn" id="<% =objRst1("CommentId") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="picaddPost(<% =objRst1("CommentId") %>);">Edit</div>
							<!-----------------Edit Reply Popup Window --------------->
							<div id="editP<% =objRst1("CommentId") %>" class="dialog_content_txt upload-text">
								<div id="dialog_content" class="dialog_content_txt upload-text-content">
									<div class="dialogModal_content">
										<div class="upload-head"><p>Enter your text here.</p></div>
										<div class="txt-close"><div class="close text-close" onclick="closeidtP(<% =objRst1("CommentId") %>);">&times</div></div>
										<div style="  width: 78%; margin: auto;">	
											<form action="" method="post">
												<div class="textarea" style="margin-bottom:20px;margin-top: 30px;">
													<textarea style="width:100%" id="txtaddP<% =objRst1("CommentId") %>" onkeyup="Editabled(<% =objRst1("CommentId") %>)" rows="7" cols="45" placeholder="Write some inspirational thoughts..."><% =objRst1("CommentText") %></textarea>
												</div>							
											</form>
										</div>
										<div class="submitxt">
										<button type="button" onclick="txtsubP(<% =objRst1("CommentId") %>);" class="txtSubmit"  id="txtsub<% =objRst1("CommentId") %>" disabled >Submit</button>
										</div>
									</div>
								</div>
							</div>
							<!-----------------Popup Window End --------------->
						<%Else%>
							<div class="follow-button">
								<!-----------------Follow Page Reload --------------->
								<%If intFollow Then %>
									<% strSQL = "select * FROM [User_Follow] where MasterKey='" & session("lngMasterKey") & "' and FollowID='" & objRst1("MasterKey") & "'" %>
									<% Call OpenRecordset(4, strSQL, session("strPage"))	%>
									<% If Not objRst4.BOF And Not objRst4.EOF Then%>
										<div class="unfollow-buttonn Funfollow<% =objRst1("MasterKey") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="Funfollow(<% =objRst1("MasterKey") %>);">Unfollow</div>
									<% Else %>
										<div class="unfollow-buttonn Ffollow<% =objRst1("MasterKey") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="Ffollow(<% =objRst1("MasterKey") %>);">Follow</div>
									<% End If%>
								<!-----------------Page No Reload --------------->
								<% Else %>
									<% strSQL = "select * FROM [User_Follow] where MasterKey='" & session("lngMasterKey") & "' and FollowID='" & objRst1("MasterKey") & "'" %>
									<% Call OpenRecordset(4, strSQL, session("strPage"))	%>
									<% If Not objRst4.BOF And Not objRst4.EOF Then%>
										<div class="unfollow-buttonn unfollow<% =objRst1("MasterKey") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="unfollow(<% =objRst1("MasterKey") %>);">Unfollow</div>
										<div class="unfollow-buttonn follow<% =objRst1("MasterKey") %>" style="display:none;cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="follow(<% =objRst1("MasterKey") %>);">Follow</div>
									<% Else %>
										<div class="unfollow-buttonn follow<% =objRst1("MasterKey") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="follow(<% =objRst1("MasterKey") %>);">Follow</div>
										<div class="unfollow-buttonn unfollow<% =objRst1("MasterKey") %>" style="display:none;cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="unfollow(<% =objRst1("MasterKey") %>);">Unfollow</div>
									<% End If%>
								<%End If%>
							</div><!--follow-button-->
						<% End If%>	
						<!-----------------Edit Post End------------------>
					</div>
					<!------------OCT23 End-------------->
					<div style="margin-top: 10px;">
						<p><% =objRst1("CommentText") %></p>
					</div>
				<div style="padding-bottom:-10px;display:block;height:auto;overflow:hidden;">
					<div  style="padding-left:0px; padding-top:10px;padding-right:0px;/*padding-bottom:10px;border-bottom:1px solid #DBDBDB; margin-bottom:10px*/">
						<div id="tag<% =objRst1("CommentId") %>" style="border-radius:5px;color:gray;display:none">Tags:</div>
					</div>
					<script>
						if(tagsa == ""){
							tagsa = 'Uncategorized';
						}
						$("#tag<% =objRst1("CommentId") %>").text("Tags: " + tagsa);
					</script>
					<div style="width:100%; margin:0 auto;height: 35px;">
					<% strSQL = "SELECT * FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del<>'false' AND Comments.ParentCommentId='" & objRst1("CommentId") & "' ORDER BY Date_Created ASC" %>
					<% Call OpenRecordset(2, strSQL, session("strPage"))	%>
					<% If Not objRst2.BOF And Not objRst2.EOF Then%>
						<div class="hidereply" style="display:none" id="hidereply<% =objRst1("CommentId") %>"><span>Hide Reply</span></div>
						<div class="hidereply" id="viewreply<% =objRst1("CommentId") %>"><span>View Reply</span></div>
					<% End If%>
						<div style="float:right;padding-right:0px;display:inline-block;padding-top:15px;">
							<div  style="float:left;"><div style=" padding-top:5px;text-align:center;"><img src="<%=session("strCDN")%>/member/img/thumbup.png" id="<% =objRst1("CommentId") %>" class="poplike" width="20px;" style="cursor: pointer;padding-right: 0px; margin-bottom:7px;margin-right: 10px;"></div></div>
							<div  style="float:left;"><span style="border-radius:5px;background-color:#E1E1E1; padding:4px 6px;float:right;margin-right: 10px;font-size: 15px;"><span class="<% =objRst1("CommentId") %>"><% =objRst1("Count_Of_Likes") %></span> Likes</span></div>
							<div class="replybtn" id="replybtn<% =objRst1("CommentId") %>" style="float:left;"><span style="cursor: pointer;border-radius:5px;background-color:#ED018A; color:white;padding:4px 6px;float:right;">Reply</span></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					$("#hidereply<% =objRst1("CommentId") %>").click(function(){
						$("#replytopost<% =objRst1("CommentId") %>").hide();
						$("#viewreply<% =objRst1("CommentId") %>").show();
						$("#hidereply<% =objRst1("CommentId") %>").hide();
					});

					$("#viewreply<% =objRst1("CommentId") %>").click(function(){
						$("#replytopost<% =objRst1("CommentId") %>").show();
						$("#hidereply<% =objRst1("CommentId") %>").show();
						$("#viewreply<% =objRst1("CommentId") %>").hide();
					});
				</script>
				<div id="reply-textarea" class="reply<% =objRst1("CommentId") %>" style="padding:25px 0 60px 0; width:95%;margin:0 auto;border-radius:5px;margin-top:10px;display:none;">
					<form style="width:95%;margin:0 auto; ">
						<textarea class="replyarea form-control replycon<% =objRst1("CommentId") %>" id="re<% =objRst1("CommentId") %>" onkeyup="abled<% =objRst1("CommentId") %>()" rows="5" style="width:100%;max-width:100%;border-radius: 5px;border: 1px solid #DBDBDB;"></textarea>
						<div class="replypost rpostbutton replypost<% =objRst1("CommentId") %>" id="<% =objRst1("CommentId") %>">Post</div>
					</form>
				</div>
				<script type="text/javascript">
					$("#replybtn<% =objRst1("CommentId") %>").click(function(){
						$(".reply<% =objRst1("CommentId") %>").toggle();
					});
					function abled<% =objRst1("CommentId") %>(){
						var cc = $("#re<% =objRst1("CommentId") %>").val();
						if (cc !==""){
						$(".replypost<% =objRst1("CommentId") %>").removeClass("rpostbutton");
						}
						else{
						$(".replypost<% =objRst1("CommentId") %>").addClass("rpostbutton");
						}
					}
				</script>
				<div id="replytopost<% =objRst1("CommentId") %>" style="display:none;">
				<% str=objRst1("CommentId") %>
				
					<% strSQL = "SELECT * FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del<>'false' AND Comments.ParentCommentId='" & objRst1("CommentId") & "' ORDER BY Date_Created ASC" %>
					<% Call OpenRecordset(2, strSQL, session("strPage"))	%>
					<% If Not objRst2.BOF And Not objRst2.EOF Then%>
						<% Do%>
								<div style="width: 100%;height: 10px;border-bottom: 1px solid #DBDBDB;"></div>
								<div class="replymain" style="margin:0 auto;margin-top:10px;">
								<!------------OCT23-------------->
									<div style="height:25px">
										<div style="font-size:16px;color:rgb(67, 143, 244);font-weight:700;float: left; margin-right: 5px;margin-top:5px"><% =objRst2("Handle") %></div>
										<div style="color:#B9B9B9;font-size:16px;margin-top:5px;float:left"><% =objRst2("Date_Created") %></div>
										
										<!-----------------Edit Reply------------------>
										<% str3= objRst2("MasterKey")%>						
										<% str4= session("lngMasterKey")%>
										
										<% If str3=str4 Then%>
											<div id="<% =objRst2("CommentId") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 2px 12px; float: right;" onclick="picadd(<% =objRst2("CommentId") %>);">Edit</div>										
											<!-----------------Edit Reply Popup Window --------------->
											<div id="edit<% =objRst2("CommentId") %>" class="dialog_content_txt upload-text">
												<div id="dialog_content" class="dialog_content_txt upload-text-content">
													<div class="dialogModal_content">
														<div class="upload-head"><p>Enter your text here.</p></div>
														<div class="txt-close"><div class="close text-close" onclick="closeidt(<% =objRst2("CommentId") %>);">&times</div></div>
														<div style="  width: 78%; margin: auto;">	
															<form action="" method="post">
																<div class="textarea" style="margin-bottom:20px;margin-top: 30px;">
																	<textarea style="width:100%" id="txtadd<% =objRst2("CommentId") %>" onkeyup="Editabled(<% =objRst2("CommentId") %>)" rows="7" cols="45" placeholder=" "><% =objRst2("CommentText") %></textarea>
																	<label class="replyword<% =objRst2("CommentId") %>" style="display:none" ><% =objRst2("CommentText") %></label>
																</div>							
															</form>
														</div>
														<div class="submitxt">
														<button type="button" onclick="txtsub(<% =objRst2("CommentId") %>);" class="txtSubmit" id="txtsub<% =objRst2("CommentId") %>" disabled >Submit</button>
														</div>
													</div>
												</div>
											</div>
											<!-----------------Popup Window End --------------->
										<% End If%>
										<!-----------------Edit Reply End------------------>
									</div>
									<!------------OCT23 End-------------->
									<p style="margin-top:10px"><% =objRst2("CommentText") %></p>
								</div>
							<% objRst2.MoveNext%>
						<% Loop Until objRst2.EOF%>
					<% End If%>
				</div>
				</div>
			<%End If%>




		<!-----------------intMine--------------->
		<!-----------------intMine--------------->
		<!-----------------intMine--------------->
		<%Else%>
			<%'intMine%>
				<div class="comboli" style="background-color:#FFF;width:100%; margin:5px auto;display:block; border-style: solid;border-width: 1px; border-color:#DBDBDB; padding:20px;height:auto; border-radius: 5px;display:none;">
					<div>
						<div style="font-size:16px;color: #ff6446;font-weight: 700;float: left; margin-right: 5px;"><% =objRst1("Handle") %></div>
						<div style="color:#B9B9B9;font-size:16px;"><% =objRst1("Date_Created") %></div>
						<div style="float: right;width: 100px;">
							<div  style="display:block;float:right;postion:absolute;margin-top:-27px;">
								<div class="hiddenpost1" id="<% =objRst1("CommentId") %>" style="background-color:#E1E1E1;color:#3e474c;cursor: pointer;padding:4px 6px;border-radius: 5px;"><% if objRst1("IsPublic")= True Then %>Hide<% ELSE%>Share<%End if%></div>
							</div>
							<div class="remove" id="<% =objRst1("CommentId") %>" style="pfloat:right;position: relative;top: -45px;left: 107px;cursor:pointer">&times;</div>
					 	</div>
						<div id="myEdit<% =objRst1("CommentId") %>" style="cursor: pointer;border-radius: 5px; background-color: rgb(147, 147, 147);color: white; padding: 4px 9px; float: right; position: relative;top: -27px;left: 45px;" onclick="picaddPost(<% =objRst1("CommentId") %>);">Edit</div>
					 </div>
					<!-----------------Edit Reply Popup Window --------------->
					<div id="editP<% =objRst1("CommentId") %>" class="dialog_content_txt upload-text">
						<div id="dialog_content" class="dialog_content_txt upload-text-content">
							<div class="dialogModal_content">
								<div class="upload-head"><p>Enter your text here.</p></div>
								<div class="txt-close"><div class="close text-close" onclick="closeidtP(<% =objRst1("CommentId") %>);">&times</div></div>
								<div style="  width: 78%; margin: auto;">	
									<form action="" method="post">
										<div class="textarea" style="margin-bottom:20px;margin-top: 30px;">
											<textarea style="width:100%"  id="txtaddP<% =objRst1("CommentId") %>" onkeyup="Editabled(<% =objRst1("CommentId") %>)" rows="7" cols="45" placeholder="Write some inspirational thoughts..."><% =objRst1("CommentText") %></textarea>
										</div>							
									</form>
								</div>
								<div class="submitxt">
								<button type="button" onclick="txtsubP(<% =objRst1("CommentId") %>);" class="txtSubmit"  id="txtsub<% =objRst1("CommentId") %>" disabled >Submit</button>
								</div>
							</div>
						</div>
					</div>
					<!-----------------Popup Window End --------------->
					<div style="margin-top: 10px;">
						<p><% =objRst1("CommentText") %></p>
					</div>
			<% if objRst1("ParentCommentId")= -1 Then %>
					<div style="padding-bottom:-10px;display:block;height:auto;overflow:hidden;">
						<div  style="padding-left:0px; padding-top:10px;padding-right:0px;padding-bottom:15px;">
							<div id="tag<% =objRst1("CommentId") %>" style="border-radius:5px;color:gray;display:none">Tags:</div>
						</div>
					</div>
				<script>
					var tagsa =new Array();
				</script>
			<%End if%>
			<% strSQL = "SELECT Tag FROM [dbo].Tags LEFT OUTER JOIN [dbo].TagsComments on Tags.TagId = TagsComments.TagId WHERE TagsComments.CommentId='" & objRst1("CommentId") & "'" %>
			<% Call OpenRecordset(3, strSQL, session("strPage"))	%>
			<% If Not objRst3.BOF And Not objRst3.EOF Then%>
				<% Do%>
					<script>
						tagsa.unshift("<% =objRst3("Tag") %>");
					</script>
					<% objRst3.MoveNext%>
				<% Loop Until objRst3.EOF%>
			<% End If%>
				<script>
					if(tagsa == ""){
						tagsa = 'Uncategorized';
					}
					$("#tag<% =objRst1("CommentId") %>").text("Tags: " + tagsa);
				</script>
					<div style="width:100%; margin:0 auto;height: 35px;">
					<% strSQL = "SELECT * FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.del<>'false' AND Comments.ParentCommentId='" & objRst1("CommentId") & "' ORDER BY Date_Created ASC" %>
					<% Call OpenRecordset(2, strSQL, session("strPage"))	%>
					<% If Not objRst2.BOF And Not objRst2.EOF Then%>
						<div class="hidereply" style="display:none;margin-top:0px" id="hidereply<% =objRst1("CommentId") %>"><span>Hide Reply</span></div>
						<div class="hidereply" style="margin-top:0px" id="viewreply<% =objRst1("CommentId") %>"><span>View Reply</span></div>
					<% End If%>
					<div style="float:right;padding-right:0px;display:inline-block;padding-top:2px;">
						<div style="float:left;"><div style=" padding-top:5px;text-align:center;"><img src="<%=session("strCDN")%>/member/img/thumbup.png" id="<% =objRst1("CommentId") %>" class="mylike"  width="20px;" style="cursor: pointer;padding-right: 0px; margin-bottom:7px;margin-right: 10px;"></div></div>
						<div style="float:left;"><span style="border-radius:5px;background-color:#E1E1E1; padding: 4px 6px;float:right;margin-right: 10px;font-size: 15px;"><span class="<% =objRst1("CommentId") %>"><% =objRst1("Count_Of_Likes") %></span> Likes</span></div>
						<div class="replybtn"  id="replybtn<% =objRst1("CommentId") %>"  style="float:left;"><span style="cursor: pointer;border-radius:5px;background-color:#ED018A; color:white;padding:4px 6px;float:right;">Reply</span></div>
					</div>
					<script type="text/javascript">
					$("#hidereply<% =objRst1("CommentId") %>").click(function(){
						$("#replytopost<% =objRst1("CommentId") %>").hide();
						$("#viewreply<% =objRst1("CommentId") %>").show();
						$("#hidereply<% =objRst1("CommentId") %>").hide();
					});

					$("#viewreply<% =objRst1("CommentId") %>").click(function(){
						$("#replytopost<% =objRst1("CommentId") %>").show();
						$("#hidereply<% =objRst1("CommentId") %>").show();
						$("#viewreply<% =objRst1("CommentId") %>").hide();
					});
				</script>
				</div>

				<div class="reply<% =objRst1("CommentId") %>" style="padding:25px 0 60px 0; width:95%;margin:0 auto;border-radius:5px;margin-top:10px;display:none;">
                <form style="width:95%;margin:0 auto; ">
                    <textarea class="form-control replycon<% =objRst1("CommentId") %>" id="red<% =objRst1("CommentId") %>" onkeyup="abled<% =objRst1("CommentId") %>()" rows="5" style="width:100%;max-width:100%;border-radius:5px;border:1px solid #DBDBDB"></textarea>
                    <div class="replymypost rpostbutton replypost<% =objRst1("CommentId") %>" id="<% =objRst1("CommentId") %>">Post</div>
                </form>
                </div>
                <script type="text/javascript">
                    $("#replybtn<% =objRst1("CommentId") %>").click(function(){
                        $(".reply<% =objRst1("CommentId") %>").toggle();
                    });
                    var pub = '<% =objRst1("IsPublic") %>';
                    var id = "<% =objRst1("CommentId") %>";
                    if(pub == "False"){
                        $("#replybtn" + id).css('display','none');
                    }

                    function abled<% =objRst1("CommentId") %>(){
                        var cc = $("#red<% =objRst1("CommentId") %>").val();
                        if (cc !==""){
                        $(".replypost<% =objRst1("CommentId") %>").removeClass("rpostbutton");
                        }
                        else{
                        $(".replypost<% =objRst1("CommentId") %>").addClass("rpostbutton");
                        }
                    }
                </script>
			<div id="replytopost<% =objRst1("CommentId") %>" style="display:none" >
			<% strSQL = "SELECT * FROM [dbo].Comments LEFT OUTER JOIN [dbo].Users on Comments.MasterKey = Users.MasterKey WHERE Comments.ParentCommentId='" & objRst1("CommentId") & "' ORDER BY Date_Created ASC" %>
			<% Call OpenRecordset(2, strSQL, session("strPage"))	%>
			<% If Not objRst2.BOF And Not objRst2.EOF Then%>
				<% Do%>
					<div style="width: 100%;height: 10px;border-bottom: 1px solid #DBDBDB;"></div>
					<div class="replymain" style="margin:0 auto;margin-top:20px;">
						<div style="font-size:16px;color:rgb(67, 143, 244);font-weight:700;float: left; margin-right: 5px;"><% =objRst2("Handle") %></div>
						<div style="color:#B9B9B9;font-size:16px;margin-top:5px;"><% =objRst2("Date_Created") %></div>
						<p><% =objRst2("CommentText") %></p>
					</div>
					<% objRst2.MoveNext%>
				<% Loop Until objRst2.EOF%>
			<% End If%>
			</div>
				</div>
		<%End If%>
		<% objRst1.MoveNext%>
	<% Loop Until objRst1.EOF%>
<% End If%>

<div id="loadMore" style="float: right;  cursor: pointer;  background-color: #8c3eac;   padding: 4px 6px;  color: #fff;  border-radius: 5px;/* height: 0px; */margin-top: 5px;">More Comments</div>

</div>
</section>


<div class="footer">
				<!-- Footer -->
			<footer id="footer">
			<div class="container">

                <!-- Main Footer -->
				<div id="main-footer">

					<div class="row">

                        <div class="topfooter-box">
							<!--#include virtual="/member/asp/footer.asp"-->
						</div>
                    </div>

				</div>
				<!-- /Main Footer -->

				<!-- Lower Footer -->

				<div id="lower-footer">

					<div class="row">

						<div class="col-lg-8 col-md-8 col-sm-8">

							<!--#include virtual="/asp/copyright.asp"-->

						</div>

                        <div class="col-lg-4 col-md-4 col-sm-4">

							<div class="social-media">
								<ul class="social-icons-2">
									<!--#include virtual="/member/html/social.html"-->
								</ul>
							</div>

						</div>

                    </div>

				</div>
				<!-- /Lower Footer -->

			</footer>
			<!-- /Footer -->
			<!-- Back To Top -->
			<a href="#" id="button-to-top"><i class="icons icon-up-dir"></i></a>
</div>
<!-- /Container -->

		<!-- JavaScript -->

		<!-- Bootstrap -->
		<script type="text/javascript" src="<%=session("strCDN")%>/member/js/bootstrap.min.js"></script>

		<!-- Modernizr -->
		<script type="text/javascript" src="<%=session("strCDN")%>/member/js/modernizr.js"></script>

		<!-- Main Script -->
		<script type="text/javascript" src="<%=session("strCDN")%>/member/js/script.js"></script>

	<!--	<script>
					$(".replybtn").click(function(){
					  $("#reply-textarea").toggle();
					});
					$(".replypost").click(function(){
						$("#reply-textarea").hide();
					});
		</script>-->
<% If intSearch Then%>
		<script>
			$(document).ready(function () {
			if($('#Search').hasClass("search-button")){
				$("#latest").attr("style","background-color:#ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");

			}
			else{ 		
				$("#latest").attr("style","background-color:white;color:#ed018a;border:1px solid #ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");
			}		
		});		
		</script>
<%End If%>
<% If intag Then%>
<script>
			$(document).ready(function () {
			$('#Search').removeClass('search-button');
			$('#Search').attr("style","background-color:#01bf2f;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;")
			$("#latest").attr("style","background-color:white;color:#ed018a;border:1px solid #ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");	
		});		
		</script>
<%End If%>

<%If Not intMine Then%>
	<script>
		$(".replypost").each(function(){
			$(this).click(	function() {
				var id= $(this).attr("id");
				var repbody = $(".replycon" +id).val();
				var rep = repbody.replace(/'/g, "''");
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'rpcomment', uid:'<%=session("lngMasterKey")%>',cid:id,ct:rep},
					async: false,
					success:function(data) {
						location.reload() ;
					 }
			});
			$(".replyarea").val('');
				});
		})
		$(".postcomment").click(function() {
			var comment = $(".commentbody").val();
			var commentbody = comment.replace(/'/g, "''");
			//lastIndexDemo();
			var tagss = $(".commenttag").val();
			if (tagss == ""){
				tagss = "Uncategorized";
			}

			if( $("#5").is(':checked') ){
			var sharecheckbox="1";
				
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'comment', uid:'<%=session("lngMasterKey")%>',share:sharecheckbox, cb:commentbody,tag:tagss},
					async: false,
					success:function(data) {
					
					},
					error: function (request, status, error) {
							alert(request.responseText);
					}
				});
				window.location.href='talk.asp?do=recent';
			}
			else{
			var sharecheckbox="0";
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'comment', uid:'<%=session("lngMasterKey")%>',share:sharecheckbox,cb:commentbody,tag:tagss},
					async: false,
					success:function(data) {
					
					},
					error: function (request, status, error) {
							alert(request.responseText);
					}
				});
					 window.location.href='talk.asp?do=mine';
			}

		});
		$(".poplike").each(function(){
		$(this).click(function(){
		var cid = $(this).attr("id");
		if($(this).attr("class")=="poplike"){
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'like', uid:'<%=session("lngMasterKey")%>',cid:cid},
					async: false,
					success:function(data) {
						var countlikes = Number($("." +cid).html()) +1;
						$("." +cid).html(countlikes);
					}

				})
				$(this).attr("class","poplikes")

				}
		})
		});

		$(".mylike").each(function(){
		$(this).click(function(){
		var cid = $(this).attr("id");
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'like', uid:'<%=session("lngMasterKey")%>',cid:cid},
					async: false,
					success:function(data) {
						var countlikes = Number($("." +cid).html()) +1;
						$("." +cid).html(countlikes);
					}

				})
		})
		});

		function abled(){
			var cc = $(".commentbody").val();
			if (cc !==""){
			$(".postcomment").removeAttr("disabled");
			}
			else{
			$(".postcomment").attr("disabled", true);
			}
		}
		$(document).ready(function () {
			size_li = $(".comboli").size();
			if(size_li <= "10"){
			$('#loadMore').hide();
			}

			x=10;
			$('.comboli:lt('+x+')').show();
			$('#loadMore').click(function () {
				x= (x+10 <= size_li) ? x+10 : size_li;
				$('.comboli:lt('+x+')').show();
					if(x >= size_li){
						$('#loadMore').hide();
			}
			});
		
		});


		/*-------------Post Edit Function-------------*/
		function picaddPost(pid){
			$("#editP"+pid).fadeIn();
			$('#p-bg').fadeIn();
		}
		function closeidtP(pid){
			var txt="txtaddP"+pid;
			$('#p-bg').hide();
			$("#editP"+pid).hide();
			
		}
		function txtsubP(pid){
			var pid=pid;
			var txt="txtaddP"+pid;
			var txtedit=$("#"+txt).val();
				$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'Edit',txt:txtedit,cid:pid},
				async: false,
				success:function(data) {
					location.reload() ;
				}

			})		
		}

/*-------------Reply Post Edit Function-------------*/
		function picadd(pid){
			$("#edit"+pid).fadeIn();
			$('#p-bg').fadeIn();
			var txt=$('.replyword'+pid).text();
			$('#txtadd'+pid).val(txt);
		}
		function closeidt(pid){
			var txt="txtadd"+pid;
			$('#p-bg').hide();
			$("#edit"+pid).hide();
			
		}
		function txtsub(pid){
			var pid=pid;
			var txt="txtadd"+pid;
			var txtedit=$("#"+txt).val();
				$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'editReply',txt:txtedit, uid:'<%=session("lngMasterKey")%>',pid:pid},
				async: false,
				success:function(data) {
					location.reload() ;
				}

			})		
		}
		/*-------------Disable Edit submit button-------------*/		
		function Editabled(id){
			var txt="txtadd"+id;
			var txtedit=$("#"+txt).val();
			if (txtedit !==""){
			$("#txtsub"+id).removeAttr("disabled");
			}
			else{
			$("#txtsub"+id).attr("disabled", true);
			}
		}
		/*-----------Follow Function without Page Reload--------*/
		function follow(id){			
			$('.follow'+id).hide();
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'follow',uid:'<%=session("lngMasterKey")%>',pid:id},
				async: false,
				success:function(data) {
					$('.unfollow'+id).show();
				}
			})

		}
		
		function unfollow(id){
			$('.unfollow'+id).hide();			
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'unfollow',uid:'<%=session("lngMasterKey")%>',pid:id},
				async: false,
				success:function(data) {
					$('.follow'+id).show();
				}
			})			
		}
		/*-----------Follow Function with Page Reload--------*/
		function Ffollow(id){			
			$('.Ffollow'+id).hide();
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'follow',uid:'<%=session("lngMasterKey")%>',pid:id},
				async: false,
				success:function(data) {
					location.reload() ;
				}
			})

		}
		function Funfollow(id){
			$('.Funfollow'+id).hide();			
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'unfollow',uid:'<%=session("lngMasterKey")%>',pid:id},
				async: false,
				success:function(data) {
					location.reload() ;
				}
			})
			
		}
	</script>



<%Else%>
	<script>
		$(".hiddenpost1").each(function(){
		$(this).on("click", function(){
		var cid = $(this).attr("id");
		if($("#" + cid).text() =="Hide"){
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'hide', cid:cid},
					async: false,
					success:function(data) {
						$("#" + cid).text("Share");
						$("#replybtn" + cid).css('display','none');
					 }
			});
		}
		else{
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'share', cid:cid},
					async: false,
					success:function(data) {
						$("#" + cid).text("Hide");
						$("#replybtn" + cid).css('display','block');

					 }
			});
		}
		});
		});

	$(".remove").each(function(){
		$(this).click(	function() {
			var id= $(this).attr("id");
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'removecomment', uid:'<%=session("lngMasterKey")%>',cid:id},
				async: false,
				success:function(data) {
					location.reload() ;
				 }
		});

			});
	})

	$(".replymypost").each(function(){
		$(this).click(	function() {
			var id= $(this).attr("id");
			var repbody = $("#red" +id).val();
			var rep = repbody.replace(/'/g, "''");

			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'rpcomment', uid:'<%=session("lngMasterKey")%>',cid:id,ct:rep},
				async: false,
				success:function(data) {
					location.reload() ;
				 },
							error: function (request, status, error) {
									alert(request.responseText);
		}
		});

			});
	})

		$(".postcomment").click(function() {
			var comment = $(".commentbody").val();
			var commentbody = comment.replace(/'/g, "''");
			//lastIndexDemo();
			var tagss = $(".commenttag").val();
			if( $("#5").is(':checked') ){
			var sharecheckbox="1";
				
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'comment', uid:'<%=session("lngMasterKey")%>',share:sharecheckbox, cb:commentbody,tag:tagss},
					async: false,
					success:function(data) {
						
					},
					error: function (request, status, error) {
							alert(request.responseText);
					}
				});
				window.location.href='talk.asp?do=recent';
			}
			else{
			var sharecheckbox="0";
				$.ajax({
					url: '../ajax-talk.asp',
					type: 'POST',
					data: { do:'comment', uid:'<%=session("lngMasterKey")%>',share:sharecheckbox,cb:commentbody,tag:tagss},
					async: false,
					success:function(data) {
						location.reload();
					},
					error: function (request, status, error) {
							alert(request.responseText);
					}
				});
			}

		});


	$(".poplike").each(function(){
	$(this).click(function(){
	var cid = $(this).attr("id");
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'like', uid:'<%=session("lngMasterKey")%>',cid:cid},
				async: false,
				success:function(data) {
					var countlikes = Number($("." +cid).html()) +1;
					$("." +cid).html(countlikes);
				}

			})
	})
	});

	$(".mylike").each(function(){
	$(this).click(function(){
	var cid = $(this).attr("id");
	if($(this).attr("class")=="mylike"){
			$.ajax({
				url: '../ajax-talk.asp',
				type: 'POST',
				data: { do:'like', uid:'<%=session("lngMasterKey")%>',cid:cid},
				async: false,
				success:function(data) {
					var countlikes = Number($("." +cid).html()) +1;
					$("." +cid).html(countlikes);
				}

			})
					$(this).attr("class","mylikes")

			}
	})
	});

	function abled(){
		var cc = $(".commentbody").val();
		if (cc !==""){
		$(".postcomment").removeAttr("disabled");
		}
		else{
		$(".postcomment").attr("disabled", true);
		}
	}

	$(document).ready(function () {
		size_li = $(".comboli").size();
		if(size_li <= "10"){
		$('#loadMore').hide();
		}

		x=10;
		$('.comboli:lt('+x+')').show();
		$('#loadMore').click(function () {
			x= (x+10 <= size_li) ? x+10 : size_li;
			$('.comboli:lt('+x+')').show();
				if(x >= size_li){
					$('#loadMore').hide();
		}
		});
	});

	function picaddPost(pid){
		$("#editP"+pid).fadeIn();
		$('#p-bg').fadeIn();
	}
	function closeidtP(pid){
		var txt="txtaddP"+pid;
		$('#p-bg').hide();
		$("#editP"+pid).hide();
		
	}
	function txtsubP(pid){
		var pid=pid;
		var txt="txtaddP"+pid;
		var txtedit=$("#"+txt).val();
			$.ajax({
			url: '../ajax-talk.asp',
			type: 'POST',
			data: { do:'Edit',txt:txtedit,cid:pid},
			async: false,
			success:function(data) {
				location.reload() ;
			}

		})		
	}
	function Editabled(id){
		var txt="txtadd"+id;
		var txtedit=$("#"+txt).val();
		if (txtedit !==""){
		$("#txtsub"+id).removeAttr("disabled");
		}
		else{
		$("#txtsub"+id).attr("disabled", true);
		}
	}
</script>
<%End If%>
<script>
	$("#Search").click(function(){
		$("#Search").removeClass('search-button');
		$("#latest").attr("style","background-color:white;color:#ed018a;border:1px solid #ed018a;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");
		$("#Popular").attr("style","background-color:white;color:#8c3eac;border:1px solid #8c3eac;border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");
		$("#mypost").attr("style","background-color:white;color:rgb(147, 147, 147);border:1px solid rgb(147, 147, 147);border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");
		$("#follow").attr("style","background-color:white;color:rgb(59, 80, 247);border:1px solid rgb(59, 80, 247);border-radius:5px;padding:6px 10px;font-size:15px;padding-top: 5px;");
	})	
</script>


		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/jquery.placeholder.js"></script>
			<script type="text/javascript" src="js/script_ie.js"></script>
		<![endif]-->


	</body>

</html>
<%Call DoCleanup()%>
