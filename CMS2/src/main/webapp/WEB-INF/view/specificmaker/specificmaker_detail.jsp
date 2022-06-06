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
                    <a class="result_down_btn" download=""  href='/digit/${outcome.outcome_file.replace("_minimal_markers.txt", ".xlsx")}' onclick="<c:out value='DownloadBtn(${outcome.outcome_id});'/>">분석파일다운</a>
                </div>
                
                <div class="mab_top_bar">
                    <!--
                    <div class="mab_bar_right mab_bar">
                        <div class="input_file_wrap">
                            <div class="data_sample_down">
                                <a download href="/upload/sampleFile/ABH_Genotypes_sample.csv">샘플파일다운</a>
                                <input type="text" class="file_text" placeholder="" readonly disabled>
                                <input id="input-file1" type="file" class="addMabcFile">
                            </div>
                            <div class="flie_btn_box first_flie_btn_box">
                                <label for="input-file1" class="file_add">파일첨부</label>
                            </div>
                            <div class="data_sample_down">
                                <a download href="/upload/sampleFile/option_data_sample.txt">샘플파일다운</a>
                                <input type="text" class="file_text" placeholder="" readonly disabled>
                                <input id="input-file2" type="file" class="addMabcFile">
                            </div>
                            <div class="flie_btn_box">
                                <label for="input-file2" class="file_add">파일첨부</label>
                                <button type="button" class="save" onclick="InsertBtn();">분석실행</button>
                            </div>
                        </div>
                    </div>
                    <div class="view">
                        <div class="commonBtn" onclick="runScreen();">분석실행</div>
                    </div>
                    -->
                </div>
                <div class="mab_chr_wrap">
                    <div class="mab_chr_wrap_center">
                        <div class="btn_all_box">
                            <div class="commonBtn download">
								<a download="<c:out value='${outcome_file}'/>" href='/digit/${outcome.outcome_file.replace(".txt", ".csv")}' onclick="<c:out value='DownloadBtn(${outcome.outcome_id});'/>">내려받기</a>
                            </div>
                            <div class="btn_all_box_content">
								<div id="grid1" style="margin-top:50px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
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
<script type="text/javascript">
	//파일 로더 
	async function initTable(url)
	{
		let response = await fetch(url);
	    let data = await response.blob();
	    let metadata = {type: "text"};
	    let file = new File([data], "qtl.txt", metadata);
		  
		getText(file);
	}
	
	function changeFileUpdate(e)
	{
		getText(e.files[0]);
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
	    
	    for(var i =0;i<headers.length;i++)
	    {
	    	var headersArray = headers[i].split("\t");
	    	
	    	for(var j = 0;j<headersArray.length ; j++)
	    	{
				al='center';

				if(j==0)
				{
					w=100;
				}
				else if(j==1)
				{
					w=140;
				}
				else
				{
					w=150;
				}

	    		columns.push(
	    		{
	        		header : headersArray[j].replace(/"/gi,""), 
					width: w,
	        		name : j,
	        		align: al
	        	})
	    	}
	    }
	 
	    for(var i = 1; i < lines.length - 1; i++)
	    {
			var words = lines[i].split(",");
			
			for(var z=0;z<words.length;z++)
			{
				var d = words[z].split("\t");
				var tempOb = {};
				
				for(var j =0;j<d.length;j++)
				{
					tempOb[j] = d[j]
	        	}
				
	        	datas.push(tempOb);
			}
	    }
	    
	    var Grid = tui.Grid;
	    const grid = new Grid(
	    {
			scrollY: true,
			scrollX: true,
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
	
    //해당 페이지 탭 active css 주기
    var pathname = window.location.pathname;
    var pathArray = pathname.split("/");
    
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
    	 var _url = XSSCheck('${outcome.outcome_file}', 1); 
    	
    	initTable(_url);
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
    
    function XSSCheck(str, level)
    {
    	if (level == undefined || level == 0)
    	{
    		str = str.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g,"");
    	}
    	else if(level != undefined && level == 1)
    	{
    		str = str.replace(/\</g, "&lt;");
    		str = str.replace(/\>/g, "&gt;");
    	}
    	
    	return str;
    }
</script>
</body>
</html>