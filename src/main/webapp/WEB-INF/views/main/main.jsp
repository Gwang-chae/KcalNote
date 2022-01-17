<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
<meta name="viewport" content="width=device-width" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<!--   Core JS Files   -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<script src="/myapp/resources/dash_assets/js/bootstrap.min.js" type="text/javascript"></script>
	
	<!--  Charts Plugin -->
	<script src="/myapp/resources/dash_assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="/myapp/resources/dash_assets/js/bootstrap-notify.js"></script>
    
	
	<!-- Chart.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	
	<!-- datepicker -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
	<link rel="icon" type="image/png" href="/myapp/resources/dash_assets/img/favicon.ico">
	
	<!-- Bootstrap core CSS     -->
    <link href="/myapp/resources/dash_assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="/myapp/resources/dash_assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="/myapp/resources/dash_assets/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/myapp/resources/dash_assets/css/pe-icon-7-stroke.css" rel="stylesheet" />
	
	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="/myapp/resources/dash_assets/js/demo.js"></script>
	
	<link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />
	
	<title>KcalNote</title>
	<style>
	@font-face { font-family: 'NanumGothic';
				 src: url('/myapp/resources/fonts/NanumGothic.eot');
				 src: url('/myapp/resources/fonts/NanumGothic.eot') format('embedded-opentype'),
				url('/myapp/resources/fonts/NanumGothic.woff') format('woff');}
	body {font-family: 'NanumGothic', 'serif';}
	
	</style>
	<script>
    	$(document).ready(function(){
       	 	$("#datepicker").datepicker();

        	$.notify({
            	icon: 'pe-7s-gift',
            	message: "KcalNote를 통해<br/> 당신의 식단을 건강하게 꾸려보세요!!"

            },{
                type: 'info',
                timer: 4000
            });
			
        	$.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd',
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                showMonthAfterYear: true,
                yearSuffix: '년'
            });
        });

	</script>
	<script>
		$(function(){
			var kcal = 0; var carbo = 0; var protein = 0; var fat = 0;
			$(".kcal").each(function(){
				kcal += Number($(this).text());
			});
			$(".carbo").each(function(){
				carbo += Number($(this).text());
			});
			$(".protein").each(function(){
				protein += Number($(this).text());
			});
			$(".fat").each(function(){
				fat += Number($(this).text());
			});
			
			// 기초대사량 산식
			// 남성 66.7 + (13.75 * weight) + (5 * height) - (6.76 * age)
			// 여성 665.1 + (9.56 * weight) + (1.85 * height) - (4.68 * age)
			var gender = "${member.gender}";
			var weight = "${member.weight}";
			var height = "${member.height}";
			var age = "${member.age}";
			
			var rmr = 0;
			if (gender == "M"){
				rmr = 66.7 + (13.75 * weight) + (5 * height) - (6.76 * age);
			}else{
				rmr = 665.1 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
			}
			
			// 권장섭취칼로리
			var rci = (height - 100) * 0.9 * 35;
			
			rmr = Math.round(rmr * 100 / 100);
			rci = Math.round(rci * 100 / 100);
			
			// 현재 날짜 값을 얻고 Date 객체로 생성
			var nowDate = "${date}";
			var date = new Date(nowDate);
			
			// 현재 날짜 6일 전부터 현재까지 총 7일을 weekDate에 담을 것임 
			var weekDate = new Array();
			date.setDate(date.getDate() - 6)
			
			for (var i=0;i<7;i++){
				var year = date.getFullYear();
				var month = date.getMonth() + 1;
				var day = date.getDate();
				var fulldate = year.toString() + "-" + month.toString() + "-" + day.toString()
				weekDate[i] = fulldate;
				date.setDate(date.getDate() + 1);
			}
			
			// 날짜에 맞게 kcalList 삽입을 위한 임시 리스트
			var temp = new Array();
			$(".weekKcal").each(function(index){
				temp[index] = $(this).val();
			});
			
			var kcalList = [0, 0, 0, 0, 0, 0, 0];
			// notedate의 날짜에 맞게 kcalList에 삽입
			$(".notedate").each(function(index){
				var notedate = $(this).val().toString().substring(0, 10);
				for (var j=0;j<7;j++){
					if (weekDate[j] == notedate){
						kcalList[j] = temp[index];
					}
				}
			});
			
			$("#todayKcal").text(kcal + "(kcal)");
			$("#todayCarbo").text(carbo + "(g)");
			$("#todayProtein").text(protein + "(g)");
			$("#todayFat").text(fat + "(g)");
			$("#todayRmr").text(rmr + "(kcal)");
			$("#todayRci").text(rci + "(kcal)");
			
			var context = document.getElementById('myChart').getContext('2d');
		    var myChart = new Chart(context, {
		    	type: 'pie', // 차트의 형태
		        data: { // 차트에 들어갈 데이터
		        	labels: ['탄수화물','단백질','지방'],
		            datasets: [{label: '차트 확인', //차트 제목
		            			fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
		            			data: [carbo, protein, fat],
		            			backgroundColor: [ 
		            				'#578E03',
		                        	'#BD9964',
		                        	'#F2E5D3'],
			                    borderColor: [
			                        //경계선 색상
			                    	'#578E03',
		                        	'#BD9964',
		                        	'#F2E5D3'],
		                    	borderWidth: 1}]},
		        options: {scales: {yAxes: [{ticks: {beginAtZero: true}}]}}
		    });
		    
		    // 라인차트
		    // rmr, rci array
		    var rmrList = [rmr, rmr, rmr, rmr, rmr, rmr, rmr];
		    var rciList = [rci, rci, rci, rci, rci, rci, rci];
		    
		    var context = document.getElementById('myLineChart').getContext('2d');
		    var myLineChart = new Chart(context, {
		    	type: 'line', // 차트의 형태
		        data: { // 차트에 들어갈 데이터
		        	labels: weekDate,
		            datasets: [{label: '기초대사량', //차트 제목
			            			fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			            			data: rmrList,
			            			backgroundColor: [ 
			            				'#F25257'],
				                    borderColor: [
				                        //경계선 색상
				                    	'#F25257'],
			                    	borderWidth: 1.5},
		                    	{label: '권장섭취칼로리', //차트 제목
			            			fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			            			data: rciList,
			            			backgroundColor: [ 
			            				'#07B2DB'],
				                    borderColor: [
				                        //경계선 색상
				                    	'#07B2DB'],
			                    	borderWidth: 1.5},
		                    	{label: '내 섭취칼로리', //차트 제목
			            			fill: true, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			            			data: kcalList,
			            			backgroundColor: [ 
			            				'#4BA349'],
				                    borderColor: [
				                        //경계선 색상
				                    	'#4BA349'],
			                    	borderWidth: 1}]},
		        options: {scales: {yAxes: [{ticks: {beginAtZero: true}}]}}
		    });
		    
		});
	</script>
    <style>
 		form{display:inline;}
	</style>
</head>
<body>
<div class="wrapper">
    <div class="sidebar" data-color="green" data-image="/myapp/resources/dash_assets/img/sidebar-3.jpg">
    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="/myapp/main/main?date=${date}" class="simple-text">
                    KcalNote
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="/myapp/main/main?date=${date}">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a href="/myapp/member/memberEdit?date=${date}">
                        <i class="pe-7s-user"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <li>
                    <a href="/myapp/main/searchAll?date=${date}">
                        <i class="pe-7s-search"></i>
                        <p>Table List</p>
                    </a>
                </li>
                <li>
                	<a href="/myapp/main/addForm?date=${date}">
                		<i class="pe-7s-plus"></i>
                        <p>Add FoodInfo</p>
                	</a>
                </li>
                <li>
                	<a href="/myapp/main/boardList?date=${date}">
                		<i class="pe-7s-note2"></i>
                        <p>Our Diet</p>
                	</a>
                </li>
            </ul>
    	</div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/myapp/main/main?date=${date}" id="navTitle">Dashboard</a>
                </div>
                <div class="collapse navbar-collapse">
                	<ul class="nav navbar-nav navbar-left">
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                        	<form action="/myapp/main/search" id="searchForm" onsubmit="return searchWordCheck()">
								<input type="text" name="searchWord" id="searchWord" placeholder="음식 검색"/>
								<input type="hidden" name="date" id="pagedate_search" value="${date}"/>
								<button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
							</form>	
                        </li>
                        <li>
	                        <form method="get" action="/myapp/main/main" id="datepick">
								<input type="text" name="date" id="datepicker" placeholder="날짜 선택">
								<button class="btn btn-default" type="submit" value="확인"><i class="fa fa-calendar"></i></button>
							</form>
                        </li>
                        <li>
                           <a href="/myapp/member/memberEdit">
                               <p>${logName}님</p>
                            </a>
                        </li>
                        <li>
                            <a href="/myapp/member/logout">
                                <p>Log out</p>	
                            </a>
                        </li>
						<li class="separator hidden-lg"></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="card">
	                <div class="row">
	                	<div class="col-md-12">
	                		<div>
		                		<div class="header">
		                            <h4 class="title">${date}</h4>
		                        	<p class="category">${date}일의 기록입니다.</p>
		                        </div>
		                        <div class="content">
		                        	<div class="row">
			                        	<div class="col-md-3">
			                        		<div class="card">
			                        			<p>
			                        				<i class="pe-7s-gym" style="font-size: 35px; padding-left:20px;"></i>
			                        				<span class="number" id="todayKcal" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">칼로리 : &nbsp</span>
			                        				
			                        			</p>
			                        		</div>
			                        	</div>
			                        	<div class="col-md-3">
			                        		<div class="card">
			                        			<p>
			                        				<i class="fa fa-cutlery" style="font-size: 35px; padding-left:20px; padding-top:2.5px; padding-bottom:2.5px;"></i>
			                        				<span class="number" id="todayCarbo" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">탄수화물 : &nbsp</span>
			                        			</p>
			                        		</div>
			                        	</div>
			                        	<div class="col-md-3">
			                        		<div class="card">
			                        			<p>
			                        				<span class="icon"><i class="fa fa-spoon" style="font-size: 35px; padding-left:20px; padding-top:2.5px; padding-bottom:2.5px;"></i></span>
			                        				<span class="number" id="todayProtein" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">단백질 : &nbsp</span>
			                        			</p>
			                        		</div>
			                        	</div>
			                        	<div class="col-md-3">
			                        		<div class="card">
			                        			<p>
			                        				<i class="pe-7s-piggy" style="font-size: 35px; padding-left:20px;"></i>
			                        				<span class="number" id="todayFat" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">지방 : &nbsp</span>
			                        			</p>
			                        		</div>
			                        	</div>
			                        </div>
			                        <div class="row">
			                        	<div class="col-md-6">
			                        		<div class="card">
			                        			<p>
			                        				<span class="icon"><i class="fa fa-heart" style="font-size: 35px; padding-left:20px;"></i></span>
			                        				<span class="number" id="todayRmr" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">내 기초대사량 : &nbsp</span>
			                        			</p>
			                        		</div>
			                        	</div>
			                        	<div class="col-md-6">
			                        		<div class="card">
			                        			<p>
			                        				<span class="icon"><i class="fa fa-check" style="font-size: 35px; padding-left:20px;"></i></span>
			                        				<span class="number" id="todayRci" style="float:right; font-size: 1.3em; padding-top:5px;"></span>
			                        				<span class="title" style="float:right; font-size: 1.3em; padding-top:5px;">내 권장섭취칼로리 : &nbsp</span>
			                        			</p>
			                        		</div>
			                        	</div>
			                        </div>
		                        </div>
	                        </div>
	                	</div>
	                </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card">

                            <div class="header">
                                <h4 class="title">탄단지</h4>
                                <p class="category">탄수화물 단백질 지방</p>
                            </div>
                            <div class="content">
                                <div id="chartPreferences">
									<!--차트가 그려질 부분-->
									<canvas id="myChart"></canvas>
                                </div>

                                <div class="footer">
                                    <div class="legend">	
                                        <i class="fa fa-circle text-info"></i> 탄수화물
                                        <i class="fa fa-circle text-danger"></i> 단백질
                                        <i class="fa fa-circle text-warning"></i> 지방
                                    </div>
                                    <hr>
                                    <div class="stats">
                                        <i class="fa fa-clock-o"></i> Campaign sent 2 days ago
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">섭취 칼로리 동향</h4>
                                <p class="category">일주일 간의 섭취 칼로리 동향입니다.</p>
                            </div>
                            <div class="content">
                                <c:forEach var="wKcal" items="${wKcal}" varStatus="idx">
                                	<input type="hidden" class="weekKcal" value="${wKcal.weekKcal}">
                                	<input type="hidden" class="notedate" value="${wKcal.notedate}">
                                </c:forEach>
                                <div >
                                	<canvas id="myLineChart"></canvas>
                                </div>
                                <div class="footer">
                                    <div class="legend">
                                    </div>
                                    <hr>
                                    <div class="stats">
                                        <i class="fa fa-history"></i> Updated 3 minutes ago
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card ">
                            <div class="header">
                                <h4 class="title">오늘 내가 먹은 음식들</h4>
                                <p class="category">음식들을 기록합니다.</p>
                            </div>
                            <div class="content">
                                <div class="table-full-width">
                                    <table class="table">
                                        <thead>
											<tr>
												<td></td>
												<td>음식 이름</td>
												<td>1회 제공량</td>
												<td>칼로리</td>
												<td>탄수화물</td>
												<td>단백질</td>
												<td>지방</td>
												<td>회사명</td>
												<td>내 섭취량</td>
											</tr>
										</thead>
                                        <tbody>
                                            <c:forEach var="vo" items="${lst}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>${vo.name}</td>
                                                <td class="servingwt">${vo.servingwt} g</td>
                                                <td class="kcal">${Math.round((vo.kcal * vo.amount)*100/100)}</td>
												<td class="carbo">${Math.round((vo.carbo * vo.amount))*100/100}</td>
												<td class="protein">${Math.round((vo.protein * vo.amount))*100/100}</td>
												<td class="fat">${Math.round((vo.fat * vo.amount))*100/100}</td>
												<td class="company">${vo.company}</td>
												<td>${vo.amount}</td>
                                                <td class="td-actions text-right">
                                                	<form method="get" action="/myapp/main/update" id="noteUpdate">
                                                		<input type="number" class="form-control" name="quantity" id="quantity" placeholder="1.0" step="0.1" min="0.1" value="1.0" style="text-align:right; width:75px; display:inline;"/>
                                                		<input type="hidden" name="noteid" id="noteid" value="${vo.noteid}"/>
                                                		<input type="hidden" name="date" id="pagedate_update" value="${date}"/>
                                                		<button type="submit" rel="tooltip" title="Update" class="btn btn-info btn-simple btn-xs">
                                                        	<i class="fa fa-edit"></i>
                                                    	</button>
                                                	</form>
                                                    <form method="get" action="/myapp/main/delete" id="noteDelete">
	                                                    <input type="hidden" name="noteid" id="noteid" value="${vo.noteid}"/>
	                                                    <input type="hidden" name="date" id="pagedate_delete" value="${date}"/>
	                                                    <button type="submit" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
	                                                        <i class="fa fa-times"></i>
	                                                    </button>
                                                    </form>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="footer">
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                </nav>
                <p class="copyright pull-right">
                </p>
            </div>
        </footer>

    </div>
</div>
</body>
</html>