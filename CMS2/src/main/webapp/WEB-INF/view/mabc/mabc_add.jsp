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
    <link rel="stylesheet" href="/digit/css/MABC_analysis/common.css">
    <link rel="stylesheet" href="/digit/css/MABC_analysis/style.css">
    <link rel="stylesheet" href="/digit/css/MABC_analysis/media.css">
    <link rel="stylesheet" href="/digit/css/alarm.css">
    <script src="/digit/vendor/jquery-3.6.0.js"></script>
    <script src="/digit/vendor/makeXlsx.js"></script>
    <script src="/digit/vendor/makeXlsxFile.js"></script>
    <script src="/digit/vendor/xlsxCdn.js"></script>
    <script src="/digit/js/MABC_analysis/common.js"></script>
    <script src="/digit/js/nav.js"></script>
    <script src="/digit/js/alarm.js"></script>    
    <script src="/digit/js/MABC_analysis/html2canvas.js"></script>
    <script src="/digit/js/MABC_analysis/script.js"></script>
</head>
<body>
    <div id="wrap">
	    <div style="position:absolute; left:50px; bottom:150px; display: none;">
	    len
	     <input type="file" onchange="onChangeLen()" class="addMabcFile" id="len_file">
	     </div>
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
                    <h2 class="data_table_title">MABC 분석 [MABC analysis]</h2>
                    <!-- a download href="dataFile/test_MABC.xlsx">결과파일다운</a -->
                </div>
                <div class="mab_top_bar">
                    <div class="mab_bar_left mab_bar">
                        <div class="select_box add_select_box">
                            <div class="select_wrap">
                                <span class="data_name">작목</span>
                                <select class="type_select" id="crop_selection">
                                	<option >작목 선택</option>
	                            	<c:forEach var="crop" items="${crop}">
	                                	<option value="<c:out value='${crop.crop}'/>"><c:out value="${crop.crop}"/></option>
	                                </c:forEach>
                                </select>
                            </div>
                        	<div class="select_wrap">
                                <span class="data_name">유전체 DB 버전</span>
	                            <select class="type_select_info" id="genomic_information" name="marker_id">
	                                <option value=""></option>
	                            </select>
                            </div>
                        
                        </div>

                        <div class="input_file_wrap">
                            <input type="file" onchange="onChangeLen()" class="addMabcFile" id="len_file">
                            <!-- <label for="len_file">파일첨부</label> -->
                        </div>
                        
                    </div>
                    <div class="mab_bar_right mab_bar add_bar_right">
                        <div class="input_file_wrap">
                            <a download href="/digit/upload/sampleFile/(업로드용)고추-mab_예제파일.xlsx" class="ex_data add_ex_data">샘플파일다운(샘플화일:고추V1.55)</a>
                            <input type="text" class="file_text" placeholder="" readonly disabled>
                            <form action="insertOutcomeResult" id="insertForm" method="POST" enctype="multipart/form-data">
                            	<input id="input-file" type="file" class="addMabcFile" onchange="readExcel()" name="file">
                            </form>
                            <div class="flie_btn_box">
                                <label for="input-file" class="file_add">파일첨부</label>
                                <div style="display:none;"class="lenPos" id="marker_file"></div>
                                <button class="save cont_btn add_re_btn" onclick="onClickInit(true)">초기화</button>
                            </div>
                              	<div class="memo_wrap">
	                               <div id="memo" style="display: none;">
		                                <span class="memo_text">메모</span>
		                            	<input type="text" id="outcome_comment">
	                               </div>
	                               <button class="save cont_btn" id="dataSaveBtn" style="display: none;" onclick="InsertOutcomeResult()">분석저장</button>
	                           </div>
                            <input type="hidden" id="user_username" name="user_username" value="<c:out value='${user.user_username}'/>">
                        </div>
                    </div>
                    <div class="view add_view">
                        <div class="commonBtn" onclick="AnalysisBtn(3)">MABC 분석실행</div>
                    </div>
                    <p class="give_info"></p>
                </div>
                <div class="mab_chr_wrap">
                    <div class="mab_chr_wrap_left">
                        <div class="btn_all_box add_btn_all_box">
                            <div class="chr_btn_wrap">
                                <p></p>
                                <div>
                                    <!-- <div class="commonBtn active" onclick="onClickInit()">초기화</div> -->
                                </div>
                            </div>
                            <div class="chr_select_wrap add_chr_select_wrap">
                            
                  	             <div class="download_btn_wrap" style="display:flex;">
	                                <select class="downloadSelectBox" style="margin-right:10px;">
				                        <option disabled selected>파일 선택</option>
				                        <option>table</option>
				                        <option>map</option>
				                    </select>
					                <div class="commonBtn download" onclick="onClickDownload()">내려받기</div>                            
                            	</div>
								                            
								
								<div class='card_header_wrap'>								
	                                <select class="chrSelectBox" onchange="onChangeChrSort()">
	                                    <option disabled selected>회복율정렬 선택</option>
	                                </select>
	                                <div class="card_checkbox_wrap">                                
	                                	<input type="checkbox" class="commonBtn allchr checkbox" onclick="onClickAllChr(this)"><p>All chromosome</p>
	                                </div>
								</div>
                            </div>
                        </div>
                    </div>
                    <div class="mab_chr_wrap_right">
                        <!-- div class="commonBtn" onclick="downloadGraphImg()">내려받기</div -->
                    </div>
                </div>


                <!-- 그래프 -->
                <div class="table_page_wrap">
                    <div class="visualWrapPosition visualWrapPosition2">
                        <div class="visualWrap">
                            <div class="tableWrap">
                                <div class="tableContent">
                                    <table id="table" class="table">
                                    </table>
                                </div>
                            </div>
                            <div class="graphContainer">
                                <div class="graphWrap">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <!-- 모달입니다! -->
    <div class="modal">
        <div class="modalBg" onclick="closeMOdal()"></div>

        <div class="modalContent">
            <button onclick="closeMOdal()" class="modal_close">닫기</button>
            <div class="modal_title">
                <p>MABC 상세</p>
                <button class="modalZoomBtn" onclick="downloadModalImg()">내려받기</button>
            </div>
            <select class="mabcModalSelect" onchange="onChangeModalSelect()">
                <option disabled selected>개체선택</option>
            </select>

            <div class="modalGraph_Container">
                <div class="modalGraph_control">
                    <button class="modalZoomBtn" onclick="onClickZoom(true)">+</button>
                    <button class="modalZoomBtn" onclick="onClickZoom(false)">-</button>
                    <input onchange="onChangeModalSlider(this)" type="range" min="1" max="8" value="3" class="modalSlider" >
                </div>
                <div class="modalGraph_Wrap">
                    <div class="modalGraph_scale"></div>
                </div>
            </div>
        </div>

    </div>

    <script type="text/javascript">
    /*
        document.addEventListener('DOMContentLoaded', () => {
            const outList = document.querySelectorAll('.out_list');
            const navList = document.querySelectorAll('.list_link');
        
            function headerActive() {
                // 현재 HTML 이름 + 확장자
                let thisHTMLName = document.URL.substring(document.URL.lastIndexOf('/') + 1, document.URL.length);
            
                navList.forEach((item) => {
                    let link = item.getAttribute('href');
                    let linkName = link.split('/');
                    if(linkName[1] === thisHTMLName) {
                        
                        navList.forEach((items) => {
                            let parent = items.parentNode;
                            parent.classList.remove('active');
                        });
                        outList.forEach((items) => {
                            items.classList.remove('on');
                        }); 
        
                        item.parentNode.parentNode.parentNode.classList.add('on');
                        item.parentNode.classList.add('active');
                    };
                });
            
            
            
            };
            headerActive();
        });
    */
    
	$(document).ready(function()
	{
		SelectMarkerVersion("고추");
	});
	
	$("#crop_selection").change(function()
	{
		var marker_crop = $("#crop_selection").val();
		
		SelectMarkerVersion(marker_crop);
	});
	
	function SelectMarkerVersion(e)
	{
		var data = {"marker_crop" : e};
		
		$.ajax(
		{
			url : "selectUseMarkerVersion",
			method : "POST",
			dataType : "json",
			data : data,
			success : function(result)
			{
				var version_list = $("#genomic_information");
				var add_list = "";
				
				add_list += '<option value="0" hidden>유전체 정보 버전 선택</option>';
				
				for(var i = 0; i < result.length; i++)
				{
					add_list += '<option value="' + result[i].marker_id + '">' + result[i].marker_version + '</option>';
				}
				
				version_list.empty();
				version_list.append(add_list);
			}
		});
	}
	
	$("#genomic_information").change(function()
	{
		var data = {"marker_id" : $("#genomic_information").val()};
		
		$.ajax(
		{
			url : "mabc/selectMarkerFile",
			method : "POST",
			dataType : "json",
			data : data,
			success : function(result)
			{
                var lenURL = "";
                result.map(item => {
                    if(item.marker_file_type == 1){
                        lenURL = item.marker_file;
                    }
                })
                
				$("#marker_file").text(lenURL);
				
				onChangeVersion();
				$(".give_info").text(result[0].marker_credit);

                readMakerFile(result);
			}
		});
	});
	
    function AnalysisBtn(e)
    {
    	onClickRun();
    	InsertAnalysis(e);
    }
    
    function InsertAnalysis(e)
    {
    	$.ajax(
		{
			url : "insertAnalysis",
			method : "POST",
			dataType : "json",
			data : {"type" : e},
			success : function()
			{
			}
		});
    }
    </script>
</body>
</html>