<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디지털육종정보화시스템</title>
    <link rel="stylesheet" href="/digit/css/reset.css">
    <link rel="stylesheet" href="/digit/css/common_header.css">
    <link rel="stylesheet" href="/digit/css/phylogeneticMarker/common.css">
    <link rel="stylesheet" href="/digit/css/phylogeneticMarker/style.css">
    <link rel="stylesheet" href="/digit/css/phylogeneticMarker/media.css">
    <link rel="stylesheet" href="/digit/css/style.css">
    <link rel="stylesheet" href="/digit/css/alarm.css">
    <script src="/digit/vendor/jquery-3.6.0.js"></script>
    <script src="/digit/js/nav.js"></script>
    <script src="/digit/js/MABC_analysis/common.js"></script>
    <script src="/digit/js/alarm.js"></script>
    <style>
      #main .view {
    	justify-content: right;
	}
	
        .data_table_title_wrap .result_down_btn {
    margin-left: 20px !important;
	}

.data_table_title_wrap .result_down_btn {
    background: none;
    color: #000;
    text-decoration: underline;
    height: 20px;
    line-height: 20px;
    padding-left: 15px;
    background: url(/images/download.svg) no-repeat left center;
    width: 120px;
}

	
    </style>
</head>
<body>
    <div id="wrap">
        <div class="tb_blank"></div>
		<header id="header">
			<div class="logo1">
				<a href="/digit/home"><img src='./images/logo.png' width="100%"></a>
			</div>
			<nav id="nav">
                <ul class="out_list_wrap">
                    <li class="out_list">
                        <p class="out_list_text">디지털분석시스템</p>
						<c:if test="${user.user_type != 0}">
                       		 <ul class="inner_list_wrap">
                       	 </c:if>
                       	 <c:if test="${user.user_type == 0}">
                       		 <ul class="inner_list_wrap_admin">
                       	 </c:if>							
                            <li class="inner_list">
                                <a class="list_link" href="/digit/karyotype_list" style="text-indent: 1em;">염색체 시각화</a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="/digit/map" style="text-indent: 1em;">분자표지 맵</a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="/digit/polymorphic" style="text-indent: 1em;">다형성 분자표지</a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="/digit/mabc_list" style="text-indent: 1em;">MABC 분석</a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="/digit/phylogeny" style="text-indent: 1em;">유사도 분석</a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="/digit/specificmaker" style="text-indent: 1em;">계통구분용 분자표지</a>
                            </li>
                             <c:if test="${user.user_type == 0}">
								<li class="inner_list">
									<a class="list_link" href="/digit/qtl" style="text-indent: 1em;">QTL 분석</a>
								</li>							
								<li class="inner_list">
									<a class="list_link" href="/digit/ngs_list" style="text-indent: 1em;">NGS MABC</a>
								</li>
								<li class="inner_list">
									<a class="list_link" href="/digit/snp_list" style="text-indent: 1em;">SNP 분석</a> 
								</li>
							 </c:if>
                        </ul>
                    </li>
                    <c:if test="${user.user_type == 0}">
	                    <li class="out_list">
	                        <p class="out_list_text">데이터관리</p>
	                        <ul class="inner_list_wrap">
	                            <li class="inner_list">
	                                <a class="list_link" href="/digit/marker_list" style="text-indent: 1em;">유전체 및 분자표지 데이터 베이스 관리</a>
	                            </li>
	                            <li class="inner_list">
	                                <a class="list_link" href="/digit/result_list" style="text-indent: 1em;">결과 데이터 관리</a>
	                            </li>
	                        </ul>
	                    </li>
	                    <li class="out_list">
	                        <a class="list_link" href="/digit/manage_list">
	                            <p class="out_list_text">System management</p>
	                        </a>
	                    </li>
                    </c:if>
                    <li class="out_list">
	                        <a class="list_link" href="/digit/userresult_list">
	                            <p class="out_list_text">사용자 결과 데이터 관리</p>
	                        </a>
					</li>
                </ul>
			</nav>
		</header>
        <main id="main">
            <div class="user_header">
                <div class="search_wrap">
                    <div class="tb_menu_btn">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <ul class="ui_list_wrap">
                    <li class="ui_list"><c:out value="${user.user_username}"/></li>
                    <li class="ui_list alarm">
                   		<!-- 알람 갯수 => alarm_on에 on 클라스로 활성화 비활성화 -->
						<span class="alarm_on on"><c:out value="${fn:length(notice)}"/></span>
						<div class="alarm_box">
							<!-- 알람 팝업의 제목 => alarm_num에 alarm_on의 갯수 일치 -->
							<h2 class="alarm_title">
								분석 완료 &#40;<span class="alarm_num"><c:out value="${fn:length(notice)}"/></span>&#41;
							</h2>
							<ul class="alram_list_box">
								<!-- 알림 목록 리스트 요소 -->
								<c:forEach var="n" items="${notice}">
									<li class="alram_list">
										<!-- 리스트 클릭시 페이지 이동 -->
										<c:choose>
											<c:when test="${n.outcome_type eq 1}"><a class="alram_link" href="/digit/map"></c:when>
											<c:when test="${n.outcome_type eq 2}"><a class="alram_link" href="/digit/polymorphic"></c:when>
											<c:when test="${n.outcome_type eq 3}"><a class="alram_link" href="/digit/mabc_list"></c:when>
											<c:when test="${n.outcome_type eq 4}"><a class="alram_link" href="/digit/phylogeny"></c:when>
											<c:when test="${n.outcome_type eq 5}"><a class="alram_link" href="/digit/specificmaker"></c:when>
											<c:when test="${n.outcome_type eq 6}"><a class="alram_link" href="/digit/qtl"></c:when>
											<c:when test="${n.outcome_type eq 7}"><a class="alram_link" href="/digit/ngs_list"></c:when>
											<c:when test="${n.outcome_type eq 8}"><a class="alram_link" href="/digit/snp_list"></c:when>
										</c:choose>
										<span class="alram_date"><c:out value="${n.create_date}"/></span>
										<p class="alram_title alram_text">분석 완료</p>
										<p class="alram_Ad alram_text">분석 구분:
										<c:choose>
											<c:when test="${n.outcome_type eq 1}">분자표지 맵</c:when>
											<c:when test="${n.outcome_type eq 2}">다형성 분자표지</c:when>
											<c:when test="${n.outcome_type eq 3}">MABC 분석</c:when>
											<c:when test="${n.outcome_type eq 4}">유사도 분석</c:when>
											<c:when test="${n.outcome_type eq 5}">계통구분용 분자표지</c:when>
											<c:when test="${n.outcome_type eq 6}">QTL 분석</c:when>
											<c:when test="${n.outcome_type eq 7}">NGS MABC</c:when>
											<c:when test="${n.outcome_type eq 8}">SNP 분석</c:when>
										</c:choose>
										</p>
										<p class="alram_Ad alram_text">전달 사항:
											<span class="alram_chief"><c:out value="${n.outcome_comment}"/></span>
										</p>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
                    </li>
                    <li class="ui_list" onclick="location.href='/digit/logout'"></li>
                </ul>
            </div>
            <section class="data_table_section">
                <div class="data_table_title_wrap">
                    <h2 class="data_table_title">유사도 분석 [Phylogeny analysis]</h2>
                    <a class="result_down_btn" download=""  href='/digit/${outcome.outcome_file.replace("_upgma.png", ".xlsx")}' onclick="<c:out value='DownloadBtn(${outcome.outcome_id});'/>">분석파일다운</a>
                </div>
                <!--
                <div class="data_sample_down">
                    <a download href="/upload/sampleFile/upgma_sample.csv">샘플파일다운</a>
                </div>
                -->
                <div class="mab_top_bar">
                    
                    <div class="mab_bar_right mab_bar">
                       	<form action="InsertPhylogeny" id="insertForm" method="POST" enctype="multipart/form-data">
	                        <div class="input_file_wrap">
	                            <input type="text" class="file_text" placeholder="" readonly disabled>
	                            <input id="input-file" type="file" class="addMabcFile" name="file" accept=".csv" >
	                            <div class="flie_btn_box">
	                                <label for="input-file" class="file_add">파일첨부</label>
	                                <button type="button" class="save" id="phyloSaveBtn" onclick="SaveBtn()" style="display: none;">분석저장</button>
	                            </div>
	                        </div>
						</form>
                    </div>
                    <div class="view" style="justify-content: right;">
                       <div class="commonBtn" onclick="InsertBtn()">유사도 분석실행</div>
                   </div>
                   
                </div>
                <div class="mab_chr_wrap">
                    <div class="mab_chr_wrap_center">
                        <div class="btn_all_box">
                        
                        	<div style="display:flex;">
			                    <select class="downloadSelectBox" id="select_file" onchange="onChangeSelect()">
			                        <option value="0" disabled="" selected="" hidden="">파일 선택</option>
			                        <option value="1">표준형트리</option>
			                        <option value="2">방사형트리</option>
			                        <option value="3">터미널노드</option>
			                    </select>
			                    
	                            <div class="commonBtn download">
	                            	<a download="upgma.png" id="downloadImg" onclick="<c:out value='DownloadBtn(${outcome.outcome_id});'/>">내려받기</a>
	                            </div>
                        	</div>
                            
                            
                            <div class="btn_all_box_content">
                                <img style="max-width: 35%;" id="result_img" alt="" src="">
                                <img style="max-width: 35%;" id="result_img2" alt="" src="">
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
  
<div class="popAlert" id="alert" style="display:none;"> <!-- alert 호출방법은 return Alert('내용')으로 하시면 됩니다 !! return 필수-->
    <div class="alert_table">
        <div class="alert_inner">
            <div class="alert_cover">
                <div class="title_text"></div>
                <button type="button">확인</button>
            </div>
        </div>
    </div>
</div>

<div class="popAlert" id="confirm" style="display:none;">
    <div class="alert_table">
        <div class="alert_inner">
            <div class="alert_cover">
                <div class="title_text"></div>
                <div class="btn_box">
                    <button type="button" id="ok_button" onclick="return true">확인</button>
                    <button type="button" id="no_button">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="load_wrap">
    <div class="load">
        <h2>잠시만 기다려주세요</h2>
        <div class="loader"></div>
    </div>
</div>
<div class="dim" style="display:none"></div>
<script type="text/javascript">

    //해당 페이지 탭 active css 주기
    var pathname = window.location.pathname;
    var pathArray = pathname.split("/");
    $("#"+pathArray[1]).addClass("active");
    if(pathArray[2] != null){
        $("."+pathArray[2]).addClass("active");
    }
    
    function InsertBtn()
	{
    	
    	
		var data = new FormData($("#insertForm")[0]);
		
		if(document.getElementById("input-file").files.length == 0){
			alert("파일을 첨부해주세요");
			return;
		}
		
		
		var loading = document.querySelector('.load_wrap');
		loading.classList.add('on');
		
		$.ajax(
		{
			url : "insertPhylogeny",
			type : "POST",
			data : data,
			cache : false,
			contentType : false,
			processData : false,
			xhr: function()
			{
				var xhr = $.ajaxSettings.xhr();
				
				xhr.upload.onprogress = function(e)
				{
					//progress 이벤트 리스너 추가
					var percent = parseInt(e.loaded * 100 / e.total);
					
					document.getElementsByClassName("load")[0].children[0].innerHTML = "잠시만 기다려주세요.<br/>" + percent + "% 진행중입니다.";
					
					if(percent == 100)
					{
						document.getElementsByClassName("load")[0].children[0].innerHTML = "잠시만 기다려주세요.<br/>분석 준비중입니다.";
					}
				};
				
				return xhr;
			},
			success : function(result)
			{
				loading.classList.remove('on');
				
				$("#result_img").attr("src", result + "_upgma_1.png");
				$("#result_img2").attr("src", result + "_upgma_2.png");
				$("#result_file").attr("href", result + "_upgma.png");
				$("#outcome_file").val(result);
				
				$(".download").css("display", "block");
				$("#download_file").attr("href", result + "_upgma.png");
				
				$("#phyloSaveBtn").css("display", "block");
				
		    	$.ajax(
    			{
    				url : "insertAnalysis",
    				method : "POST",
    				dataType : "json",
    				data : {"type" : 4},
    				success : function()
    				{
    				}
    			});
			},
			error : function(e)
			{
				loading.classList.remove('on');
				
				console.log(e);
			}
		});
	}

    function Alert(text){ //popup

        $("#alert").show();
        $(".dim").show();
        $("#alert .title_text").text(text);

        $("#alert button").click(function(){
        	$("#alert, .dim").hide();
		 
            //return location.reload();
        });
        return false;
    }

    function Alert1(text){ //popup

        $("#alert").show();
        $(".dim").show();
        $("#alert .title_text").text(text);

        $("#alert button").click(function(){
            $("#alert, .dim").hide();
        });
    }
    
    function clearScreen(){
    	Alert('스크린이 초기화되었습니다')
    }
    
   	var _url = '${outcome.outcome_file.replace("_upgma.png", "_upgma_1.png")}';
   	var _url2 = '${outcome.outcome_file.replace("_upgma.png", "_upgma_2.png")}';
   	var _url3 = '${outcome.outcome_file.replace("_upgma.png", "_upgma_list.csv")}';
    function runScreen(){
    	
    	document.getElementById("result_img").src = '/' + _url;
    	document.getElementById("result_img2").src = '/' + _url2;
    }
    
    runScreen();
    
    function DownloadBtn(e)
    {
		$.ajax(
		{
			url : "updateOutcomeFileStatus",
			method : "POST",
			dataType : "json",
			data : {"outcome_id" : e},
			success : function()
			{
			}
		});
    }   
    
    function onChangeSelect(){
    	
    	var select_file = document.querySelector("#select_file");
    	var selectText = select_file.options[select_file.selectedIndex].innerText;
		
		var downloadImg = document.querySelector("#downloadImg");;
		if(selectText == "표준형트리"){
			downloadImg.setAttribute("download", "upgma.png")
			downloadImg.setAttribute("href", _url)
		}else if(selectText == "방사형트리"){
			downloadImg.setAttribute("download", "upgma.png")
			downloadImg.setAttribute("href", _url2)
		}else{
			downloadImg.setAttribute("download", "upgma_list.csv")
			downloadImg.setAttribute("href", _url3)
			return;
		}

		
    }
</script>
</html>