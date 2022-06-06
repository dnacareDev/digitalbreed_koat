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
    <link rel="stylesheet" href="/digit/css/lineSpecificMaker/common.css">
    <link rel="stylesheet" href="/digit/css/lineSpecificMaker/style.css">
    <link rel="stylesheet" href="/digit/css/lineSpecificMaker/media.css">
    <link rel="stylesheet" href="/digit/css/style.css">
    <link rel="stylesheet" href="/digit/css/alarm.css">
    <script src="/digit/vendor/jquery-3.6.0.js"></script>
    <script src="/digit/js/nav.js"></script>
	<script src="/digit/js/MABC_analysis/common.js"></script>
    <script src="/digit/js/alarm.js"></script>
    <style>
        .card {
            box-shadow: 0 3px 20px 3px rgb(0 0 0 / 7%);
        }

        table {
            border-top: 1px solid grey;
            border-collapse: collapse;
        }

        th, td {
            border-bottom: 2px solid #E5E9F2;
            padding: 20px;
            text-align: center;
            font-weight: initial;
        }

        th, tbody tr {
            background-color: white;
        }
    
    #main .view {
    	justify-content: right;
	}
	.mab_top_bar div.view {
	    position: absolute;
	    right: 0;
	    bottom: 0;
	    width: 220px;
	    height: 48px;
	    font-size: 14px;
	    font-weight: bold;
	    text-align: center;
	    display: flex;
	}
    

     .runBtn {
     		width: 160px;
		    height: 40px;
		    font-size: 14px;
		    line-height: 40px;
		    text-align: center;
		    border: none;
		    background: #397FF4;
		    color: #fff;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		    margin: 0 0px 0 6px;
		    position: relative;
		    z-index: 1;
	 }
    	.commonBtn {
    	width: 160px;
		    height: 40px;
		    font-size: 14px;
		    line-height: 40px;
		    text-align: center;
		    border: none;
		    background: #397FF4;
		    color: #fff;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		    margin: 0 0px 0 6px;
		    position: relative;
		    z-index: 1;
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
                    <h2 class="data_table_title">계통구분용 분자표지 [Line specific marker]</h2>
                    <!-- <a download href="/digit/dataFile/test_MABC.xlsx">결과파일다운</a> -->
                </div>
                
                <div class="mab_top_bar">
                    <div class="mab_bar_right mab_bar">
                    	<form action="InsertSpecific" id="insertForm" method="POST" enctype="multipart/form-data">
	                        <div class="input_file_wrap">
	                            <div class="data_sample_down">
	                                <a download href="/digit/upload/sampleFile/(업로드용)참외_최소마커_예제파일.xlsx">샘플파일다운(샘플화일:참외)</a>
	                                <input type="text" class="file_text" placeholder="" readonly disabled>
	                                <input id="input-file1" type="file" class="addMabcFile" name="main_file" accept=".xlsx">
	                            </div>
	                            <div class="flie_btn_box first_flie_btn_box">
	                                <label for="input-file1" class="file_add">파일첨부</label>
	                            </div>
	                            
	                            <div class="data_sample_down" style="display: none;">
	                                <a download href="/digit/upload/sampleFile/option_data_sample.txt">샘플파일다운</a>
	                                <input type="text" class="file_text" placeholder="" readonly disabled>
	                                <input id="input-file2" type="file" class="addMabcFile" name="option_file" accept=".txt">
	                            </div>
	                            <div class="flie_btn_box" style="display: none;">
	                                <label for="input-file2" class="file_add">파일첨부</label>
	                            </div>
                              	<div class="memo_wrap">
	                               <div id="memo" style="display: none;">
		                                <span class="memo_text">메모</span>
		                            	<input type="text" id="outcome_comment">
	                               </div>
	                                <button type="button" class="save" id="specSaveBtn" onclick="SaveBtn();" style="display: none;">분석저장</button>
	                           </div>
	                        </div>
                        </form>
                    </div>
                    <div class="view"> 
                     	<button type="button" class="runBtn" onclick="InsertBtn();">계통구분용 분자표지 분석실행</button>
                    </div>
                </div>
                <div class="mab_chr_wrap">
                    <div class="mab_chr_wrap_center">
                        <div class="btn_all_box">
                            <!--div class="commonBtn download">
                            	<a download href="/${outcome.outcome_file}">내려받기</a>
                            </div-->
                            <div class="btn_all_box_content">
								<div id="grid1" style="margin-top:50px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="user_username" value="<c:out value='${user.user_username}'/>">
                <input type="hidden" id="outcome_file">
            </section>
        </main>
    </div>
    
	<div class="load_wrap">
	    <div class="load">
	        <h2>잠시만 기다려주세요</h2>
	        <div class="loader"></div>
	    </div>
	</div>
	
    <div class="modal done_modal">
        <div class="modal_box">
            <h2 class="done_tite">분석이 진행중입니다.</h2>
            <button type="button" class="commonBtn" onclick="CloseModal()">확인</button>
        </div>
    </div>
</body>
<script type="text/javascript">

	//파일 로더 
	async function initTable(url){
		let response = await fetch(url);
	    let data = await response.blob();
	    let metadata = {
	      type: "text"
	    };
	    let file = new File([data], "qtl.txt", metadata);
		  
		getText(file);
	}

	function changeFileUpdate(e){
		getText(e.files[0]);
	}
	
	function getText(fileToRead) {
        var reader = new FileReader(); 
        reader.readAsText(fileToRead);
        reader.onload = loadHandler;
        reader.onerror = errorHandler;
    }

    function loadHandler(event) {
        var csv = event.target.result;
        process(csv);
    }

    async function process(csv) {

    	var lines = csv.split("\n");

        result = [];
        var headers = lines[0].split(",");
        var headerTag = "";
        var columns =  []
        var datas = [];
        for(var i =0;i<headers.length;i++){
        	var headersArray = headers[i].split("\t");
        	for(var j = 0;j<headersArray.length ; j++){
        		columns.push({
            		header : headersArray[j].replace(/"/gi,""), 
            		name : j,
            		align: 'center'
            	})
        	}
        	
        }
     
        for (var i = 1; i < lines.length - 1; i++) {
			var words = lines[i].split(",");
			
			for(var z=0;z<words.length;z++){
				var d = words[z].split("\t");
				var tempOb = {};
				for(var j =0;j<d.length;j++){
					tempOb[j] = d[j]
	        	}
	        	datas.push(tempOb);
			}
        }

        
        var Grid = tui.Grid;
        const grid = new Grid({
            el: document.getElementById('grid1'),
            columns:columns, 
            data: datas
        });
        
        Grid.applyTheme('striped'); 
    }

    function errorHandler(evt) {
	    if (evt.target.error.name == "NotReadableError") {
	        alert("Canno't read file !");
	    }
    }

	function InsertBtn()
	{
		var data = new FormData($("#insertForm")[0]);
		
		if(document.getElementById("input-file1").files.length == 0){
			alert("파일을 첨부해주세요");
			return;
		}
		
		var loading = document.querySelector('.load_wrap');
		loading.classList.add('on');
		
		$.ajax(
		{
			url : "insertSpecific",
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

				var url = "common/r/marker/" + result + "/" + result + "_minimal_markers.txt";
				initTable(url);
				
				$("#outcome_file").val("common/r/marker/" + result + "/" + result);
				
				document.querySelector(".modal").classList.add('on');
				
				$("#specSaveBtn").css("display", "block");
				$("#memo").css("display", "flex");
				
		    	$.ajax(
    			{
    				url : "insertAnalysis",
    				method : "POST",
    				dataType : "json",
    				data : {"type" : 5},
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
	
	function SaveBtn()
	{
		var user_username = $("#user_username").val();
		var outcome_file = $("#outcome_file").val();
		var outcome_comment = $("#outcome_comment").val();
		
		if(outcome_file == "")
		{
			alert("저장할 결과가 없습니다.")
		}
		else
		{
			var data = {"user_username" : user_username, "outcome_file" : outcome_file, "outcome_type" : 5, "outcome_comment" : outcome_comment};
			
			$.ajax(
			{
				url : "insertNewOutcome",
				type : "POST",
				data : data,
				success : function(result)
				{
					if(result == 0)
					{
						alert("저장에 실패하였습니다.");
					}
					else
					{
						alert("저장되었습니다.");
						
						location.href = "/digit/specificmaker";
					}
				},
				error : function(e)
				{
					console.log(e);
				}
			});
		}
	}
	
	function CloseModal()
	{
		document.querySelector(".modal").classList.remove('on');
	}
</script>
</html>