<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디지털육종정보화시스템</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="./css/common_header.css">
    <link rel="stylesheet" href="css/Register_result_data/common.css">
    <link rel="stylesheet" href="css/Register_result_data/result_data.css">
    <link rel="stylesheet" href="css/Register_result_data/media.css">
    <link rel="stylesheet" href="css/Register_result_data/result_media.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/alarm.css">
    <link rel="stylesheet" href="tui/tui-pagination/dist/tui-pagination.css">
    <link rel="stylesheet" href="tui/tui-grid/dist/tui-grid.css">
    <link rel="stylesheet" href="tui/tui-date-picker/dist/tui-date-picker.css">
    <link rel="stylesheet" href="tui/tui-time-picker/dist/tui-time-picker.css">
    <script src="vendor/jquery-3.6.0.js"></script>
    <script src="js/Register_result_data/common.js"></script>
    <script src="/js/nav.js"></script>
    <script src="js/alarm.js"></script>
    <script src="tui/tui-pagination/dist/tui-pagination.js"></script>
    <script src="tui/tui-date-picker/dist/tui-date-picker.js"></script>
    <script src="tui/tui-time-picker/dist/tui-time-picker.js"></script>
    <script src="tui/tui-grid/dist/tui-grid.js"></script>
</head>
<body>
    <div id="wrap">
        <div class="tb_blank"></div>
		<header id="header">
			<div class="logo">
				<a href="home">
					<img class="logo_img" src="images/logo.png" alt="로고">
				</a>
			</div>
			<nav id="nav">
                <ul class="out_list_wrap">
                    <li class="out_list">
                        <p class="out_list_text">Digital breeding System</p>
                        <ul class="inner_list_wrap">
                            <li class="inner_list">
                                <a class="list_link" href="karyotype_list">염색체 시각화 <span>[Draw karyotype]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="map">마커 맵 <span>[Draw maker map]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="polymorphic">다형성 마커 <span>[Polymorphic maker map]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="mabc_list">MABC 분석 <span>[MABC analysis]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="phylogeny">유사도 분석 <span>[Phylogeny analysis]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="specificmaker">계통구분용 마커 <span>[Line specific maker]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="qtl">QTL 분석 <span>[QTL analysis]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="ngs_list">NGS MABC <span>[NGS MABC]</span></a>
                            </li>
                            <li class="inner_list">
                                <a class="list_link" href="snp_list">SNP 분석 <span>[SNP analysis]</span></a>
                            </li>
                        </ul>
                    </li>
                    <c:if test="${user.user_type == 0}">
	                    <li class="out_list">
	                        <p class="out_list_text">Data management</p>
	                        <ul class="inner_list_wrap">
	                            <li class="inner_list">
	                                <a class="list_link" href="marker_list">유전체 및 마커정보 데이터 베이스 관리</a>
	                            </li>
	                            <li class="inner_list">
	                                <a class="list_link" href="result_list">결과 데이터 관리</a>
	                            </li>
	                        </ul>
	                    </li>
	                    <li class="out_list">
	                        <a class="list_link" href="manage_list">
	                            <p class="out_list_text">System management</p>
	                        </a>
	                    </li>
                    </c:if>
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
                    <li class="ui_list">${user.user_username}</li>
                    <li class="ui_list alarm">
                   		<!-- 알람 갯수 => alarm_on에 on 클라스로 활성화 비활성화 -->
						<span class="alarm_on on">${fn:length(notice)}</span>
						<div class="alarm_box">
							<!-- 알람 팝업의 제목 => alarm_num에 alarm_on의 갯수 일치 -->
							<h2 class="alarm_title">
								분석 완료 &#40;<span class="alarm_num">${fn:length(notice)}</span>&#41;
							</h2>
							<ul class="alram_list_box">
								<!-- 알림 목록 리스트 요소 -->
								<c:forEach var="n" items="${notice}">
									<li class="alram_list">
										<!-- 리스트 클릭시 페이지 이동 -->
										<c:choose>
											<c:when test="${n.outcome_type eq 1}"><a class="alram_link" href="map"></c:when>
											<c:when test="${n.outcome_type eq 2}"><a class="alram_link" href="polymorphic"></c:when>
											<c:when test="${n.outcome_type eq 3}"><a class="alram_link" href="mabc_list"></c:when>
											<c:when test="${n.outcome_type eq 4}"><a class="alram_link" href="phylogeny"></c:when>
											<c:when test="${n.outcome_type eq 5}"><a class="alram_link" href="specificmaker"></c:when>
											<c:when test="${n.outcome_type eq 6}"><a class="alram_link" href="qtl"></c:when>
											<c:when test="${n.outcome_type eq 7}"><a class="alram_link" href="ngs_list"></c:when>
											<c:when test="${n.outcome_type eq 8}"><a class="alram_link" href="snp_list"></c:when>
										</c:choose>
										<span class="alram_date">${n.create_date}</span>
										<p class="alram_title alram_text">분석 완료</p>
										<p class="alram_Ad alram_text">분석 구분:
										<c:choose>
											<c:when test="${n.outcome_type eq 1}">마커 맵</c:when>
											<c:when test="${n.outcome_type eq 2}">다형성 마커</c:when>
											<c:when test="${n.outcome_type eq 3}">MABC 분석</c:when>
											<c:when test="${n.outcome_type eq 4}">유사도 분석</c:when>
											<c:when test="${n.outcome_type eq 5}">계통구분용 마커</c:when>
											<c:when test="${n.outcome_type eq 6}">QTL 분석</c:when>
											<c:when test="${n.outcome_type eq 7}">NGS MABC</c:when>
											<c:when test="${n.outcome_type eq 8}">SNP 분석</c:when>
										</c:choose>
										</p>
										<p class="alram_Ad alram_text">전달 사항:
											<span class="alram_chief">${n.outcome_comment}</span>
										</p>
										</a>
									</li>
								</c:forEach>
							</ul>
							<div class="alram_footer">
								<a class="sc_status">일정 현황</a>
							</div>
						</div>
                    </li>
                    <li class="ui_list" onclick="location.href='/logout'"></li>
                </ul>
            </div>
            <section class="data_table_section result_table_section">
                <h2 class="data_table_title">결과 데이터 관리</h2>
                <div id="list_grid"></div>
                <div class="btn_wrap result_btn_wrap">
                    <button class="new_btn same_btn">신규등록</button>
                </div>
            </section>
        </main>
    </div>
    <div class="dimm">
        <div class="new_win_box new_result_box">
           <!--  <button class="win_close">닫기</button> -->
            <h2 class="new_win_title new_result_title">결과 데이터 등록</h2>
            <form action="insertOutcome" id="insert_form" class="new_data_form new_result_form modal_form" method="POST" enctype="multipart/form-data">
                <div class="data_form_box result_form_box">
                    <div class="data_left_box data_box">
                        <div class="new_data_box">
                            <label for="crop_selection" class="select_arrow">작목 선택</label>
                            <select id="crop_selection">
                            	<c:forEach var="c" items="${crop}">
	                                <option value="${c.crop}">${c.crop}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="new_data_box">
                            <label for="analysis_type" class="select_arrow">분석 종류</label>
                            <select id="analysis_type" name="outcome_type">
                                <!-- option value="0">염색체 시각화 | Draw karyotype</option -->
                                <option value="1">마커 맵 | draw marker map</option>
                                <option value="2">다형성 마커 | Polymorphic marker map</option>
                                <option value="3">MABC 분석 | MABC analysis</option>
                                <option value="4">유사도 분석 | Phylogeny analysis</option>
                                <option value="5">계통구분용 마커 | Line specific marker</option>
                                <option value="6">QTL 분석 | QTL analysis</option>
                                <option value="7">NGS MABC | NGS MABC</option>
                                <option value="8">SNP 분석 | SNP analysis</option>
                            </select>
                        </div>
                        <div class="new_data_box">
                            <label for="user_username">고객 E-mail</label>
                            <input type="email" id="user_username" name="user_username">
                        </div>
                    </div>
                    <div class="data_right_box data_box">
                        <div class="new_data_box">
                            <label for="marker_id" class="select_arrow">유전체 DB 정보 선택</label>
                            <select id="marker_id" name="marker_id">
                            </select>
                        </div>
                        <div class="new_data_box">
                            <div class="input_box">
                                <p class="form_title">결과파일 업로드</p>
                                <input type="file" class="file_in" id="result_file" name="file">
                                <p class="file_title" id="file_name">파일 첨부</p>
                            </div>
                            <label for="result_file" class="file_btn">파일첨부</label>
                        </div>
         				<div class="new_data_box">
         					<label for="outcome_status" >공개여부</label>
         					<select id="outcome_status" name="outcome_status">
                                <option value="0">미공개</option>
                                <option value="1">공개</option>
                            </select>
                        </div>
                    </div>
                    <div class="data_bottom_box data_box">
                     <div class="new_data_box">
                       <label for="outcome_comment">전달사항</label>  
                       <textarea id="outcome_comment" name="outcome_comment"></textarea>
                     </div>
                    </div>
                </div>
	            <div class="canel_save_btn">
	                <button type="button" class="save" onclick="InsertOutcome()">저장</button>
	            </div>
            </form>
        </div>
    </div>
    
    <div class="dimm dimm_modify">
        <div class="new_win_box new_result_box">
            <!-- <button class="win_close" onclick="CloseModify()">닫기</button> -->
            <h2 class="new_win_title new_result_title">결과 데이터</h2>
            <form action="updateOutcome" id="update_form" class="new_data_form new_result_form modal_form" method="POST" enctype="multipart/form-data">
                <div class="data_form_box result_form_box">
                    <div class="data_left_box data_box">
                        <div class="new_data_box">
                            <label for="crop_selection" class="select_arrow">작물 정보</label>
                            <input type="text" id="modify_crop" name="marker_crop">
                        </div>
                        <div class="new_data_box">
                            <label for="analysis_type" class="select_arrow">분석 종류</label>
                            <select id="modify_type" name="outcome_type">
                                <!-- <option value="0">염색체 시각화 | Draw karyotype</option> -->
                                <option value="1">마커 맵 | draw marker map</option>
                                <option value="2">다형성 마커 | Polymorphic marker map</option>
                                <option value="3">MABC 분석 | MABC analysis</option>
                                <option value="4">유사도 분석 | Phylogeny analysis</option>
                                <option value="5">계통구분용 마커 | Line specific marker</option>
                                <option value="6">QTL 분석 | QTL analysis</option>
                                <option value="7">NGS MABC | NGS MABC</option>
                                <option value="8">SNP 분석 | SNP analysis</option>
                            </select>
                        </div>
                        <div class="new_data_box">
                            <label for="client_email">고객 E-mail</label>
                            <input type="email" id="modify_username" name="user_username">
                        </div>
                    </div>
                    <div class="data_right_box data_box">
                        <div class="new_data_box">
                            <label for="modify_version" class="select_arrow">유전체 정보 선택</label>
                            <input type="text" id="modify_version" name="marker_version">
                        </div>
                        <div class="new_data_box">
                            <div class="input_box">
                                <p class="form_title">결과파일 업로드</p>
                                <input type="file" class="file_in" id="update_file" name="file">
                                <p class="file_title" id="modify_origin_file" name="outcome_origin_file">파일 첨부</p>
                            </div>
                            <label for="update_file" class="file_btn">파일첨부</label>
                        </div>
         				<div class="new_data_box">
         					<label for="status" >공개여부</label>
         					<select id="modify_status" name="outcome_status">
                                <option value="0">미공개</option>
                                <option value="1">공개</option>
                            </select>
                        </div>
                    </div>
                    <div class="data_bottom_box data_box">
                     <div class="new_data_box">
                       <label for="notice">전달사항</label>  
                       <textarea id="modify_comment" name="outcome_comment"></textarea>
                     </div>
                    </div>
                </div>
                <input type="hidden" id="modify_id" name="outcome_id">
                <input type="hidden" id="modify_crop_id" name="marker_id">
                <input type="hidden" id="modify_file" name="outcome_file">
                <input type="hidden" id="outcome_origin_name" name="outcome_origin_name">
	            <div class="canel_save_btn">
	                <button type="button" class="save" onclick="UpdateOutcome();">수정</button>
	            </div>
            </form>
        </div>
    </div>
    
	<div class="load_wrap">
	    <div class="load">
	        <h2>잠시만 기다려주세요</h2>
	        <div class="loader"></div>
	    </div>
	</div>
</body>
<script type="text/javascript">
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
			url : "selectMarkerVersion",
			method : "POST",
			dataType : "json",
			data : data,
			success : function(result)
			{
				var version_list = $("#marker_id");
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
	
	function InsertOutcome()
	{
		var user_username = $("#user_username").val();
		var marker_id = $("#marker_id").val();
		var result_file = $("#result_file").val();
		
		if(user_username == "")
		{
			alert("고객 Email을 입력해주세요.");
		}
		else if(marker_id == 0)
		{
			alert("유전체 정보를 선택해주세요.");
		}
		else if(result_file == "")
		{
			alert("결과 파일을 업로드해주세요.");
		}
		else
		{
			var data = new FormData($("#insert_form")[0]);
			var loading = document.querySelector('.load_wrap');
			
			loading.classList.add('on');
			
			$.ajax(
			{
				url : "insertOutcome",
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
					};
					
					return xhr;
				},
				success : function(result)
				{
					loading.classList.remove('on');
					
					location.reload();
				},
				error : function(e)
				{
					loading.classList.remove('on');
					
					console.log(e);
				}
			});
		}
	}
	
	function ModifyBtn(e)
	{
		$.ajax(
		{
			url : "selectOutcomeDetail",
			type : "POST",
			data : {"outcome_id" : e},
			success : function(result)
			{
				$("#modify_id").val(result.outcome_id);
				$("#modify_username").val(result.user_username);
				$("#modify_crop_id").val(result.marker_id);
				$("#modify_crop").val(result.marker_crop);
				$("#modify_version").val(result.marker_version);
				$("#modify_type").val(result.outcome_type).prop("selected", true);
				$("#modify_file").val(result.outcome_file);
				$("#outcome_origin_name").val(result.outcome_origin_file);
				$("#modify_origin_file").text(result.outcome_origin_file);
				$("#modify_comment").text(result.outcome_comment);
				$("#modify_status").val(result.outcome_status).prop("selected", true);
				
		        let dimmCheck = document.querySelector('.dimm_modify');
		        let dimmHas = dimmCheck.classList.contains('on');
		        
		        if(!dimmHas)
		        {
		            dimmCheck.classList.add('on');
		        };
			}
		});
	}
	
	function CloseModify()
	{
        let dimmCheck = document.querySelector('.dimm_modify');
        let dimmHas = dimmCheck.classList.contains('on');
        
        if(dimmHas)
        {
            dimmCheck.classList.remove('on');
        };
	}
	
	function UpdateOutcome()
	{
		var data = new FormData($("#update_form")[0]);
		
		var loading = document.querySelector('.load_wrap');
		loading.classList.add('on');
		
		$.ajax(
		{
			url : "updateOutcome",
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
				};
				
				return xhr;
			},
			success : function(result)
			{
				loading.classList.remove('on');
				
				location.reload();
			},
			error : function(e)
			{
				loading.classList.remove('on');
				
				console.log(e);
			}
		});
	}
	
	$(document).ready(function(){
		Grid();
	})

	function Grid()
	{
		var header = [
			{'header' : '고객 E-mail', 'name' : 'user_username', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}},
			{'header' : '작목', 'name' : 'marker_crop', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}},
			{'header' : '유전체 DB 버전', 'name' : 'marker_version', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}},
			{'header' : '분석 종류', 'name' : 'outcome_type', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}},
			{'header' : '분석 상태', 'name' : 'outcome_status', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}},
			{'header' : '전송날짜', 'name' : 'create_date', 'sortable' : true, 'filter' : {type: 'text', showApplyBtn: true, showClearBtn: true}}
		]
		
		$.ajax(
		{
			url : "SelectList",
			method : "POST",
			data : {"type" : 9},
			dataType : "JSON",
			success : function(result)
			{
				list_grid = new tui.Grid(
				{
					el : document.getElementById("list_grid"),
					scrollX : false,
					scrollY : false,
					data : result.outcome,
					rowHeaders: [
					{
						type: 'rowNum',
						renderer: RowNumRenderer,
					}],
					editingEvent : 'click',
					columns : header,
					pageOptions : {
						useClient : true,
						perPage : 10
					}
				});
				
				var outcome_list = [];
				
				for(var i = 0; i < result.outcome.length; i++)
				{
					var outcome_type = "";
					
					if(result.outcome[i].outcome_type == 1)
					{
						outcome_type = "마커 맵 ";	
					}
					else if(result.outcome[i].outcome_type == 2)
					{
						outcome_type = "다형성 마커 ";	
					}
					else if(result.outcome[i].outcome_type == 3)
					{
						outcome_type = "MABC 분석 ";	
					}
					else if(result.outcome[i].outcome_type == 4)
					{
						outcome_type = "유사도 분석 ";	
					}
					else if(result.outcome[i].outcome_type == 5)
					{
						outcome_type = "계통구분용 마커 ";	
					}
					else if(result.outcome[i].outcome_type == 6)
					{
						outcome_type = "QTL 분석 ";	
					}
					else if(result.outcome[i].outcome_type == 7)
					{
						outcome_type = "NGS MABC ";	
					}
					else if(result.outcome[i].outcome_type == 8)
					{
						outcome_type = "SNP 분석 ";	
					}
					
					var item = {"user_username" : result.outcome[i].user_username,
								"outcome_id" : result.outcome[i].outcome_id,
								"marker_crop" : result.outcome[i].marker_crop,
								"marker_version" : result.outcome[i].marker_version,
								"outcome_type" : outcome_type,
								"outcome_status" : result.outcome[i].outcome_status == 0 ? "미공개" : result.outcome[i].outcome_status == 1 ? "공개" : "분석 중",
								"create_date" : result.outcome[i].create_date};
					
					outcome_list.push(item);
				}
				
				list_grid.setColumns(header);
				list_grid.resetData(outcome_list);
				
				// 클릭 이벤트
				list_grid.on('click', (ev) => {
					if(ev.targetType == "rowHeader")
					{
						ModifyBtn(list_grid.getRow(ev.rowKey).outcome_id);
					}
				});
			}
		});
	}
	
	class RowNumRenderer
	{
		constructor(props)
		{
			const el = document.createElement('span');
			el.innerHTML = props.grid.getRowCount() - props.formattedValue + 1;
			this.el = el;
		}
		
		getElement()
		{
			return this.el;
		}
		
		render(props)
		{
			this.el.innerHTML = props.grid.getRowCount() - props.formattedValue + 1;
		}
	}
</script>
</html>