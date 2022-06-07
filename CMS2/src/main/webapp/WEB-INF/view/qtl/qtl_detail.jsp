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
    <link rel="stylesheet" href="/digit/css/QTL_marker/common.css">
    <link rel="stylesheet" href="/digit/css/QTL_marker/style.css">
    <link rel="stylesheet" href="/digit/css/QTL_marker/media.css">
    <link rel="stylesheet" href="/digit/css/style.css">
    <link rel="stylesheet" href="/digit/css/grid.css">
    <link rel="stylesheet" href="/digit/css/alarm.css">
    <script src="/digit/vendor/jquery-3.6.0.js"></script>
    <script src="/digit/js/grid.js"></script>
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
            padding: 10px;
            text-align: center;
            font-weight: initial;
        }

        th, tbody tr {
            background-color: white;
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

      #main .view {
    	justify-content: right;
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
        <main id="main" data="<c:out value='${outcome.outcome_file}'/>">
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
                    <h2 class="data_table_title">QTL 분석 [QTL analysis]</h2>
                    <a class="result_down_btn" download=""  href='/digit/${outcome.outcome_file.replace("zip", "csv")}' onclick="<c:out value='DownloadBtn(${outcome.outcome_id});'/>'">분석파일다운</a>
                </div>
                <!--
                <div class="data_sample_down">
                    <a download href="/upload/sampleFile/qtl_sample.csv">샘플파일다운</a>
                </div>
                -->
                <div class="mab_top_bar">
                
                    <div class="mab_bar_right mab_bar">
                    	<form action="InsertQTL" id="insertForm" method="POST" enctype="multipart/form-data">
	                        <div class="input_file_wrap">
	                            <input type="text" class="file_text" placeholder="" readonly disabled>
	                            <input id="input-file" type="file" class="addMabcFile" name="file" accept=".csv" >
	                            <div class="flie_btn_box">
	                                <label for="input-file" class="file_add">파일첨부</label>
	                                <button type="button" class="save" onclick="SaveBtn()">분석저장</button>
	                            </div>
	                        </div>
                        </form>
                    </div>	
                    <div class="view" >
                        <div class="commonBtn" onclick="InsertBtn()">QTL 분석실행</div>
                    </div>
                    
                </div>
                
                
               	<div class='download_btn_wrap'>
                   <select class="downloadSelectBox" id="select_file">
                        <option value="0" disabled selected hidden>파일 선택</option>
                        <option value="1">map</option>
                        <option value="2">table</option>
                    </select>
                    <div style="margin-right: auto; margin-left:10px;" class="commonBtn download" onclick="<c:out value='onClickDownload(${outcome.outcome_id})'/>">내려받기</div>                            
                </div>
                <div class="mab_chr_wrap" style="width:100%;">
                    <div class="mab_chr_wrap" style="width:100%;">
	                    <div class="mab_chr_wrap_left" style="overflow-y: scroll; width:calc(50% - 10px); margin-right:10px;">  <!-- 그래프1 -->
							<img style="max-width: 90%;" id="result-img" src="">
	                    </div>
	                    <div class="mab_chr_wrap_left mab_chr_wrap_right" style="margin-left:10px; overflow-y: scroll; width:calc(50% - 10px); height: 560px;"> 
							<div id="grid1" style="margin-top:50px;"></div>
	                    </div>
                	</div>
                </div>
                <input id="file_name" type="hidden" value="<c:out value='${outcome.outcome_file}'/>">
                
                <!-- 
                <div class="mab_chr_wrap">
                    <div class="mab_chr_wrap_center">
                        <div class="btn_all_box">
                            <div class="commonBtn download"><a id="qtl_download" href="" download>내려받기</a></div>
                            <div class="btn_all_box_content">
                                <div style="left:5px; border: 1px solid #efefef; float: left; width: 49%; height:500px;">
									<img id="result-img" src="">
								</div>
								<div style="border: 1px solid #efefef; float: left; width: 49%; height:500px;">
									<div id="grid1" style="margin-top:50px;"></div>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
                -->
            </section>
        </main>
    </div>
    
	<div class="load_wrap">
	    <div class="load">
	        <h2>잠시만 기다려주세요</h2>
	        <div class="loader"></div>
	    </div>
	</div>
	
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
	
	<div class="dim" style="display:none"></div>
</body>
    
<script type="text/javascript">
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

	async function initTable(url)
	{
		let response = await fetch(url);
	    let data = await response.blob();
	    let metadata = {type: "text/csv"};
	    let file = new File([data], "qtl.csv", metadata);
		  
		getText(file);
	}

	function initImage(url)
	{
		document.getElementById("result-img").src = url;
	}


	function handleFiles(files)
	{
		if (window.FileReader)
		{
			getText(files[0]);
		}
		else
		{
			alert('FileReader are not supported in this browser.');
		}
	}

    function getText(fileToRead)
    {
        var reader = new FileReader();
        
        reader.readAsText(fileToRead);
        reader.onload = loadHandler;
        reader.onerror = errorHandler;
    }

    function loadHandler(event)
    {
        var csv = event.target.result;
        
        process(csv);
    }

    async function process(csv)
    {
    	var lines = csv.split("\n");

        result = [];
        var headers = lines[0].split(",");
        var headerTag = "";
        var columns =  []
        var datas = [];
        
        for(var i =0; i<headers.length; i++)
        {
        	columns.push(
        	{
        		header : headers[i].replace(/"/gi,""), 
        		name : i,
        		align: 'center'
        	})
        }
     
        for (var i = 1; i < lines.length - 1; i++)
        {
			var words = lines[i].split(",");
	        var resultTag = "";
	        var tempOb = {};
	        
			for(var j =0;j<words.length;j++)
			{
				tempOb[j] = words[j].replace(/"/gi,"");
        	}
			
        	datas.push(tempOb);
        }

        var Grid = tui.Grid;
        const grid = new Grid(
        {
            el: document.getElementById('grid1'),
            columns:columns, 
            data: datas
        });
        
        Grid.applyTheme('striped'); 
    }

    function errorHandler(evt)
    {
    	if (evt.target.error.name == "NotReadableError")
    	{
    		alert("Canno't read file !");
    	}
    }

	function InsertBtn()
	{
		if(document.getElementById("input-file").files.length == 0)
		{
			alert("파일을 첨부해주세요");
			return;
		}
		
		var data = new FormData($("#insertForm")[0]);
		
		var loading = document.querySelector('.load_wrap');
		loading.classList.add('on');
		
		$.ajax(
		{
			url : "insertQTL",
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
				
				initImage(result + "_qtl.png");
				initTable(result + "_qtl.csv");
				// document.getElementById("qtl_download").setAttribute("href", result + "_qtl.png");
				
				$("#outcome_file").val(result);
			},
			error : function(e)
			{
				loading.classList.remove('on');
			}
		});
	}
	
	function SaveBtn()
	{
		var user_username = $("#user_username").val();
		var outcome_file = $("#outcome_file").val();
		
		if(outcome_file == "")
		{
			alert("저장할 결과가 없습니다.")
		}
		else
		{
			var data = {"user_username" : user_username, "outcome_file" : outcome_file, "outcome_type" : 6};
			
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
					}
				},
				error : function(e)
				{
					console.log(e);
				}
			});
		}
	}
	
 	var _url = document.getElementById("main").getAttribute("data");

	
	function onClickDownload(e)
	{
		var select_file = $("#select_file").val();
		
		if(select_file == 0)
		{
			alert("내려받을 파일을 선택하세요.");
		}
		else
		{
			let a = document.createElement('a');
	    	a.style.display = 'none';
	    	
	    	var a_url = (_url).split(".")[0];
	    	
	    	if(select_file == 1)
	    	{
	    		a.setAttribute("download", "qtl.png");
		    	a.href = a_url + "_qtl.png";
	    	}
	    	else if(select_file == 2)
	    	{
	    		a.setAttribute("download", "qtl.csv");
		    	a.href = a_url + "_qtl.csv";
	    	}
	    	
	    	document.body.appendChild(a);
	    	a.click();
	    	
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
	}
	
    //해당 페이지 탭 active css 주기
    var pathname = window.location.pathname;
    var pathArray = pathname.split("/");
    var _url = "";
    
    $("#"+pathArray[1]).addClass("active");
    
    if(pathArray[2] != null)
    {
        $("."+pathArray[2]).addClass("active");
    }

    function Alert(text)
    {
    	//popup
        $("#alert").show();
        $(".dim").show();
        $("#alert .title_text").text(text);

        $("#alert button").click(function()
        {
        	$("#alert, .dim").hide();
		 
            //return location.reload();
        });
        
        return false;
    }

    function Alert1(text)
    {
    	//popup
        $("#alert").show();
        $(".dim").show();
        $("#alert .title_text").text(text);

        $("#alert button").click(function()
        {
            $("#alert, .dim").hide();
        });
    }
    
    function clearScreen()
    {
    	Alert('스크린이 초기화되었습니다')
    }
    
    function runScreen()
    {
    	_url = document.getElementById("main").getAttribute("data");
    	
		initImage(_url.split(".")[0] + "_qtl.png");
		initTable(_url.split(".")[0] + "_qtl.csv");
    }
    
    runScreen();
    
</script>
</html>