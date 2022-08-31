
var lengthData = [];
var currentClick = "";
var gffData = {};
var today = new Date();
var searchValue = [];
var maxHeight = 452;

// # . 0 Gff 파일 읽기
function readGff () {
    var input = event.target;
    var fileForm = input.files[0].name.split(".")[1];
    if(fileForm !== "gff"){
        alert(".gff 파일이 아닙니다.");
        event.target.value = null;
        return
    };

    var reader = new FileReader();
    reader.onload = function () {
        var data = reader.result;
        parcingGff(data);
    };
    reader.readAsBinaryString(input.files[0]);
}
function parcingGff(data){
    //var newData = data.replace(/(\t)/gm, "@");
    //newData = newData.replace(/(\r\n|\n|\r)/gm, "SJH11HI").split("SJH11HI");

	// data : gff파일
	// splitLengthData : gff파일을 줄(\n) 단위로 나눈 배열
	// splitLengthData[i].indexOf("gene") : "gene"이 나타나는 위치 (=21번째)

	

    var splitLengthData = data.split("\n");
    var newLengthData = {};

	//console.log("splitLengthData : ", splitLengthData[0]);

    for(var i = 0 ; i < splitLengthData.length ; i++){

        //splitLengthData[i].indexOf("ID=") !== -1 && splitLengthData[i].indexOf("Name=") == -1 && 
        if(splitLengthData[i].indexOf("gene") !== -1 && splitLengthData[i] !== "" ){									// 각 줄마다 gene 글자가 없거나 아예 빈 줄이면 코드전개 X
            var newTextArr = splitLengthData[i].split(" ")[0].split("\t");														// newTextArr : 한줄을 탭 단위로 나눈 배열
            var chr = newTextArr[0].split("\n");																							// chr : 첫번째 탭. 유전자 번호 = 'SL4.0ch00'

			/*
			if(i == 1) {
				console.log(newTextArr, "newTextArr");
				console.log(chr, "chr");
			}
			*/

            if(splitLengthData[i].split("ID=").length <= 1)																		// id가 없으면 continue;
                continue;

            var id = splitLengthData[i].split("ID=")[1];																				// id : id= 이후로 나타나는 텍스트(이해는 안되지만 공백 이후로는 안 찍힘)

			/*
			if(i == 1) {
				console.log(id, "id");	
				console.log("id.toUpperCase() : ", id.toUpperCase());
			}
			*/

            if(newLengthData[id.toUpperCase()]){
                continue;
            }else{
                newLengthData[id.toUpperCase()] = {																				// newLengthData 객체에 id.toUpperCase() property를 하나씩 집어넣는다
                    chr : chr[chr.length-1],
                    pos : newTextArr[4],
                    id : id.toUpperCase() 
                }
            }

			/*
			if(i == 1) {
				console.log("newLengthData[id.toUpperCase()] : ", newLengthData[id.toUpperCase()]);
			}
			*/
        }
    }

    gffData = newLengthData;

	//console.log("gffData keys() : ", Object.keys(gffData));																	// gffData : 최종 데이터 

/*
    var newGffData = {};
    for(var i = 0 ; i < newData.length ; i++){
        if(newData[i] ==""){continue};
        if(newData[i][0]=="#"){continue};
        if(!newData[i].split("ID=")[1]){continue}
        
        try{
            var id = "";

            // 분기처리
            if(!newData[i].split("ID=")[1].split(":")[1]){
                id = newData[i].split("ID=")[1].split(";")[0];
            }else{
                if(newData[i].split("ID=")[1].split(":")[0].split(";")[1]){
                    id = newData[i].split("ID=")[1].split(":")[0].split(";")[0];
                }else{
                    id = newData[i].split("ID=")[1].split(":")[0];
                }
            }
            var sentenceArr = newData[i].split("@") ;
    
            if(sentenceArr[2]!=="gene"){continue};
            
            if( newGffData[id] ){
                continue;
            }else{
                newGffData[id] = {
                    chr : sentenceArr[0],
                    pos : sentenceArr[4],
                    id : id
                }
            }
        }catch{console.err(i + "_ index _ gff parse Error"); return;}
    }
    gffData = newGffData;*/
}

// # . 0 Len 파일 읽기
function onChangeLen(e){
    var input = event.target;
    var fileForm = input.files[0].name.split(".")[1];
    if(fileForm !== "len"){
        alert(".len 파일이 아닙니다.");
        event.target.value = null;
        return
    };

    var reader = new FileReader();
    reader.onload = function () {
        parsingData(reader.result);
    };
    reader.readAsBinaryString(input.files[0]);
}
// # . 1 데이터 파싱 
function parsingData(data){

	//console.log("data(서버경로의 len파일 정보) : ");
	//console.log(data);

    var spitLengthData = data.replace(/(\r\n|\n|\r)/gm, "-");
    spitLengthData = spitLengthData.split("-");

	//console.log("spitLengthData", JSON.parse(JSON.stringify(spitLengthData)));
    
	var lengthObj = {};
    
    for(var i = 0 ; i < spitLengthData.length ; i++){																	// 첫 3글자만 따서 property를 만들었다. 염색체 정보는 SL4의 배열로, 헤더는 Nam으로 가서 분리가 됨
        if(spitLengthData[i]==""){continue}
        var objEl = spitLengthData[i].split(" ")[0].substr(0, 3);
        lengthObj[objEl] = lengthObj[objEl] ? lengthObj[objEl] : [];
        lengthObj[objEl].push(spitLengthData[i]);
    }

    
    // for(var key in lengthObj){
    //     lengthObj[key].sort(function(a, b){
    //         return b.split(" ")[1] - a.split(" ")[1];
    //     });
    // }
    for(var key in lengthObj){																									// 염색체 번호 오름차순으로 정렬(현재 len파일이 이미 정렬되어있어서 의미는 없음. 만약을 대비한 코드인듯)
        lengthObj[key] =  lengthObj[key].sort((a,b)=>a.localeCompare(b))
    }

	//console.log("lengthObj : ", JSON.parse(JSON.stringify(lengthObj)));

    // 20개 제한
    // for(var key in lengthObj){
    //     if(lengthObj[key].length > 20){
    //         lengthObj[key] = lengthObj[key].slice(0, 20)
    //     }
    // }


    var newLengthData = {};
    for(var key in lengthObj){
        for(var i = 0 ; i < lengthObj[key].length ; i++){
            var objEl = lengthObj[key][i].split(" ");
            if(objEl[0] == "Name"){continue};

            newLengthData[objEl[0]] = {
                name : objEl[0],
                pos : objEl[1],
                color:{r:171,g:171,b:171,a:1},
            }
        }
    }

	//console.log("newLengthData : ", newLengthData);														// 버전+염색체명이 조합된 property. 각 property마다  name, pos, color property를 가지고있다.

    if(Object.keys(newLengthData).length == 0){
        alert("잘못된 Len파일입니다.")
        console.error("newLengthData empty");
        return;
    }

    var buttonList = {};
    for(var key in newLengthData){
        buttonList[key.replace(/[0-9\_]/g,"")] = buttonList[key.replace(/[0-9\_]/g,"")] ? buttonList[key.replace(/[0-9\_]/g,"")] : {};
    }

    var input_file_wrap = document.querySelector(".input_file_wrap");
    for(var key in buttonList){
        var button = document.createElement("button");
        button.classList.add('chart_btn');
        button.innerText = key;
        button.setAttribute("onclick", "onClickKind('"+ key +"')");

        input_file_wrap.appendChild(button);
    }
    

    lengthData = newLengthData;
    var firstBtn = document.querySelector(".chart_btn");
    if(firstBtn){
        firstBtn.click();
    }

}
// # . 2 그래프 그리기 크기순
function drawChart(kindEl){
    // drawChartName(kindEl);
    // return;

	//console.log("kindEl : ", kindEl);


    document.querySelector(".chartWrap").style.overflow = "scroll";

    var colorArr = [];
    var posArr = [];
    var keyArr = [];

	//console.log("lengthData : ", JSON.parse(JSON.stringify(lengthData)));

	// 객체인 lengthData를 3개로 분리하여 배열화
    for(var key in lengthData){
        if(key.replace(/[0-9\_]/g,"") == kindEl   ){
            var colorData = lengthData[key]["color"];
            keyArr.push(key);
            colorArr.push("rgba(  "+colorData.r+" ,  "+colorData.g + " ,  "+colorData.b+" ,  " + colorData.a +"  )"  );
            posArr.push(lengthData[key]["pos"]);
        }
    }

	//console.log("keyArr : ", keyArr);
	//console.log("posArr : ", posArr);

	// 각 염색체의 최대길이
    var highPos = 0;
    for(var i = 0 ; i < posArr.length ; i++){
        if(highPos < Number(posArr[i])){
            highPos = Number(posArr[i]);
        }
    }

    drawStandard(highPos)
    var percent =  100 / highPos;

    var chartWrap = document.querySelector(".chartWrap");
    for(var i = 0 ; i < posArr.length ; i++){
        var chartElName = document.createElement("div");
        var chartName = document.createElement("div");
        var chartEl = document.createElement("div");
        chartElName.classList.add("chartElName");
        chartName.classList.add("chartName");
        chartEl.classList.add("chartEl");

        // chartName.innerHTML = keyArr[i] + " <br /> (" + insertComma(posArr[i]) + "mb)";
        chartName.innerHTML = keyArr[i] + " <br /> (" + roundToTwo(posArr[i]/1000000) + "mb)";												// 길이 출력
        chartEl.style.height = (Number(posArr[i]) * percent) + "%";																								// 가장 긴 염색체 100% 대비 길이 조절
        chartEl.style.backgroundColor = colorArr[i];
        chartEl.setAttribute("data-column", keyArr[i]);

		//console.log("searchValue : ", searchValue);

        // gene 추가
        if(searchValue.length){																																				// 검색어 입력시 searchValue에 값이 입력된다.

            for(var j = 0 ; j < searchValue.length ; j++){
                var data = gffData[searchValue[j]];																														// 이 값을 속성으로 가진 gffData -> data
                if(data["chr"] == keyArr[i]){

                    // 스택
                    var chartStack = document.createElement('div');
                    chartStack.classList.add("chartStack");
                    var _percent = 100 / Number(posArr[i]);
                    chartStack.style.top = ( _percent * Number( data["pos"])  ) +"%";																			// data의 pos를 기반으로한 위치에 줄이 그어짐

					//if(j==12) { debugger; }

                    // 이름
                    var chartStackName = document.createElement('div');																						// 그어지는 줄의 유전자명(?)
                    chartStackName.classList.add("chartStackName");

                    chartStackName.innerHTML =searchValue[j].split(";")[0] + "<br />"+"("+insertComma(Number(data["pos"]))+")";
                    chartStackName.style.top = ( _percent * Number( data["pos"])  )+ "%";

                    // 라인																																						// stack과 name 사이에 그어지는 줄
                    var chartStackLine = document.createElement('div');
                    chartStackLine.classList.add("chartStackLine");
                    chartStackLine.style.top = ( _percent * Number( data["pos"])  ) + "%";

                    chartEl.appendChild(chartStack);
                    chartEl.appendChild(chartStackName);
                    chartEl.appendChild(chartStackLine);

					/*
					if(j==12) {
						console.log("data : ", data);
						console.log("chartStack : ", chartStack);
						console.log("chartStackName : ", chartStackName);
						console.log("chartStackLine : ", chartStackLine);
					}
					*/
					

                }
            }
        }
        
        chartElName.appendChild(chartName);
        chartElName.appendChild(chartEl);
        chartWrap.appendChild(chartElName);
    }
    calcNameLine();
    addClickEvent();
}
// # . 2 그래프 그리기 이름순
function drawChartName(kindEl){
    let newArr = [];

    for(var key in lengthData){
        if(key.replace(/[0-9\_]/g,"").toLowerCase() == kindEl.toLowerCase()   ){
            newArr.push(lengthData[key]);
        }
    }
    

    // var regex = /[^0-9]/g;				// 숫자가 아닌 문자열을 매칭하는 정규식
    // newArr.sort((a, b) => {
    //     return( a.name.replace(regex, "") - b.name.replace(regex, "") )
    // })
    
    var highPos = 0;
    for(var i = 0 ; i < newArr.length ; i++){
        if(highPos < Number(newArr[i].pos)){
            highPos = Number(newArr[i].pos);
        }
    }
    
    drawStandard(highPos)
    var percent =  100 / highPos;

    var chartWrap = document.querySelector(".chartWrap");
    for(var i = 0 ; i < newArr.length ; i++){
        var chartElName = document.createElement("div");
        var chartName = document.createElement("div");
        var chartEl = document.createElement("div");
        chartElName.classList.add("chartElName");
        chartName.classList.add("chartName");
        chartEl.classList.add("chartEl");
        
        
        // chartName.innerHTML = newArr[i].name + " <br /> (" + insertComma(Number(newArr[i].pos)) + "mb)";
        chartName.innerHTML = newArr[i].name + " <br /> (" + roundToTwo(Number(newArr[i].pos)/1000000) + "mb)";
        chartEl.style.height = (Number(newArr[i].pos) * percent) + "%";
        chartEl.style.backgroundColor = "rgba(  "+newArr[i].color.r+" ,  "+newArr[i].color.g + " ,  "+newArr[i].color.b+" ,  " + newArr[i].color.a +"  )";
        chartEl.setAttribute("data-column", newArr[i].name);

        // gene 추가
        if(searchValue.length){
            for(var j = 0 ; j < searchValue.length ; j++){
                console.log(gffData[searchValue[j]])
                var data = gffData[searchValue[j]];
                if(data["chr"] == newArr[i].name){
                    // 스택
                    var chartStack = document.createElement('div');
                    chartStack.classList.add("chartStack");
                    var _percent = 100 / Number(newArr[i].pos);
                    chartStack.style.top = ( _percent * Number( data["pos"])  ) +"%";   

                    // 이름
                    var chartStackName = document.createElement('div');
                    chartStackName.classList.add("chartStackName");
                    chartStackName.innerHTML =searchValue[j]+"<br />"+"("+insertComma(Number(newArr[i]["pos"]))+")";
                    chartStackName.style.top = ( _percent * Number( data["pos"])  )+ "%";


                    // 라인
                    var chartStackLine = document.createElement('div');
                    chartStackLine.classList.add("chartStackLine");
                    chartStackLine.style.top = ( _percent * Number( data["pos"])  ) + "%";

                    chartEl.appendChild(chartStack);
                    chartEl.appendChild(chartStackName);
                    chartEl.appendChild(chartStackLine);
                }
            }
        }
        chartElName.appendChild(chartName);
        chartElName.appendChild(chartEl);
        chartWrap.appendChild(chartElName);
    }
    

    calcNameLine();
    addClickEvent();
}
// 좌측 숫자
function drawStandard(highPos){
    var standardEls = document.querySelectorAll(".standard_wrap div");
    for(var i = 0 ; i < standardEls.length ; i++){

        let number = Math.floor((highPos / 5) * i);

		console.log(number);

        let length = String(number).length;
        let pow = Math.pow(10, length-2);

        number = number * (1/pow);
        number = Math.floor(number);
        number = number * pow;
        // standardEls[i].innerText = insertComma(number) + "mb";
        standardEls[i].innerText = roundToTwo(number/1000000) + "mb";
    }
}

// 이름 마진값, 선 길이/각도 계산
function calcNameLine(){
    var chartStackName = document.querySelectorAll(".chartStackName");

	//let queryselectorTest = document.querySelectorAll(".chartStackName")[0].parentElement;
	//console.log("queryselectorTest : " , queryselectorTest.dataset.column);
    
	// 최대 이름 길이
    if(chartStackName.length){
        var highMarginR = 0;
        for(var i = 0 ; i < chartStackName.length ; i++){
            if(highMarginR < chartStackName[i].offsetWidth){
                highMarginR = chartStackName[i].offsetWidth;
            }
        }

		
        
        var chartElName = document.querySelectorAll(".chartElName");
        for(var i = 0 ; i < chartElName.length ; i++){
            chartElName[i].style.marginRight = (highMarginR + 15) + "px"
        }

    }
            
    // 선 길이/각도
    if(chartStackName){
        var chartStack = document.querySelectorAll(".chartStackLine");
        var chartStackLine = document.querySelectorAll(".chartStackLine");
        for(var i = 0 ; i < chartStackName.length ; i++){


            if(i!==0){
                var offsetBottom = chartStackName[i-1].offsetTop + chartStackName[i-1].offsetHeight;


				if(maxHeight < offsetBottom) {
					maxHeight = offsetBottom
				}

				/*
                if(chartStackName[i].offsetTop < offsetBottom){
                    chartStackName[i].style.top = offsetBottom + "px";
                }
				*/
				
				if(chartStackName[i].offsetTop < offsetBottom){
					if(document.querySelectorAll(".chartStackName")[i].parentElement.dataset.column == document.querySelectorAll(".chartStackName")[i-1].parentElement.dataset.column) {
						chartStackName[i].style.top = offsetBottom + "px";
					}
				}
            }

            // 설명 x, y 좌표
            var nameX = chartStackName[i].offsetLeft;
            var nameY = chartStackName[i].offsetTop + (chartStackName[i].offsetHeight/2);
            
            // 스택 x, y 좌표
            var stackX = chartStack[i].offsetLeft + chartStack[i].offsetWidth;
            var stackY = chartStack[i].offsetTop + (chartStack[i].offsetHeight/2);

            // 각도구하기
            var x = nameX - stackX;
            var y = nameY - stackY;
            var radian = Math.atan2(y, x);
            var degree = radian * 180 / Math.PI // 라디안 -> 디그리 변환

            chartStackLine[i].style.transform = "rotate(" + degree + "deg)";

            // 가로길이 구하기
            chartStackLine[i].style.width = Math.sqrt(
                Math.pow((nameY - stackY), 2) + Math.pow((Math.abs(nameX - stackX)), 2)
            ) - 10 + "px";
        }
    }

    const chartStackEls = document.querySelectorAll(".chartStack");
    if(chartStackEls.length){
        $('.chartWrap').animate({scrollLeft : chartStackEls[0].parentElement.parentElement.offsetLeft}, 0); 
    }
}

// 소수점2자리
function roundToTwo(num) {
    return +(Math.round(num + "e+2")  + "e-2");
}


// ------------------------------------------------------
//                         클릭이벤트
// ------------------------------------------------------
// 탭
function onClickKind (kindEl) {
    if(document.querySelector(".active")){
        document.querySelector(".active").classList.remove("active")
    }
    event.target.classList.add('active');
    currentClick = kindEl;
    initChart();

    if(kindEl=="C"||kindEl=="Chr"){
        drawChartName(kindEl);
    }else{
        drawChart(kindEl);
    }

}
// 차트
function addClickEvent(){
    var chartElNameEls = document.querySelectorAll(".chartElName");
    for(var i = 0 ; i < chartElNameEls.length ; i++){
        chartElNameEls[i].addEventListener("click", function(e){
            if(e.path[0].classList.contains("chartEl")){
                var colorInput = document.createElement("input");
                document.querySelector("body").appendChild(colorInput);

                var input_container = document.querySelectorAll(".sp-original-input-container");
                var sp_container = document.querySelectorAll(".sp-container");
                var colorSpec = document.querySelectorAll(".colorSpec");
                for(var j = 0 ; j < input_container.length ; j++){
                    input_container[j].remove();
                    sp_container[j].remove();
                }
                for(var j = 0 ; j < colorSpec.length ; j++){
                    colorSpec[j].remove();
                }


                colorInput.setAttribute("data-name", e.path[1].children[0].innerText);
                colorInput.type = "text";
                colorInput.classList.add("colorSpec");

                $(".colorSpec").spectrum({
                    showPaletteOnly: true,
                    togglePaletteOnly: true,
                    togglePaletteMoreText: 'more',
                    togglePaletteLessText: 'less',
                    color: '',
                    palette: [
                        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
                        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
                        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
                        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
                        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
                        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
                        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
                        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
                    ]
                });

                var test = document.querySelector(".sp-original-input-container");
                test.style.position = "absolute";
                test.style.left = e.clientX + "px";
                test.style.top = e.clientY + "px";

                setTimeout(() => {
                    colorInput.click();
                }, 100);
                
                var palette = document.querySelector(".sp-palette");
                palette.addEventListener("click", function(item){
                    if(item.target.classList.contains("sp-thumb-inner")){

                        initChart();
                        var rgba = item.target.parentElement.dataset.color;
                        rgba = rgba.replace("rgb(", "");
                        rgba = rgba.replace(")", "");
                        rgba = rgba.split(",");

                        lengthData[e.target.dataset.column].color = {
                            r: rgba[0],
                            g: rgba[1],
                            b: rgba[2],
                            a: 1,
                        };
                        initChart();

                        if(currentClick=="C"||currentClick=="Chr"){
                            drawChartName(currentClick);
                        }else{
                            drawChart(currentClick);
                        }

                    }
                })

            }
        })
    }
}
// 색 변경
function onChangeColor (e) {
    initChart();
    var rgba = hexToRgb(e.value);
    lengthData[e.dataset.name].color = rgba;
    e.remove();
    initChart();

    if(currentClick=="C"||currentClick=="Chr"){
        drawChartName(currentClick);
    }else{
        drawChart(currentClick);
    }

}
// 컬러코드 RGB로 변경
function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
      r: parseInt(result[1], 16),
      g: parseInt(result[2], 16),
      b: parseInt(result[3], 16),
      a: 1,
    } : null;
}


       

// ------------------------------------------------------
//                         초기화
// ------------------------------------------------------
function initChart(){
    document.querySelector(".chartWrap").innerHTML = "";
}


// ------------------------------------------------------
//                         캡쳐
// ------------------------------------------------------
function onClickExport(){
    window.scrollTo(0,0);
    if(document.querySelector(".stackAni")){
        document.querySelector(".stackAni").classList.remove("stackAni");
    }
    var cloneParent = document.createElement('div');
    cloneParent.classList.add("cloneParent");
    var cloneEl = document.querySelector(".chart_parent").cloneNode(true);
    

    cloneEl.children[1].children[0].children[0].style.overflow = "unset";
    cloneEl.children[1].children[0].style.width = "unset";
    cloneEl.children[1].children[0].children[0].style.width = "unset";
    cloneEl.style.width = "unset";

	// 분자표지명의 위치에따라 높이를 조절
	cloneEl.style.height = maxHeight + 70 + "px"

    cloneParent.appendChild(cloneEl);
    document.querySelector("body").appendChild(cloneParent);

	let canvasDownload = document.querySelector(".chart_parent");

	html2canvas(cloneEl).then(function(canvas){
        var myImage = canvas.toDataURL(); 
        downloadURI(myImage, DateText(today) + "_karyotype_map_" + currentClick + ".png") 
    });
}

function downloadURI(uri, name){
	var link = document.createElement("a")
	link.download = name;
	link.href = uri;
	document.body.appendChild(link);
	link.click();
    document.querySelector(".cloneParent").remove();
}
function DateText(date){
    var month = String(date.getMonth()+1);
    var _date = String(date.getDate());
    
    if(month.length == 1){
        month = "0"+String(date.getMonth()+1);
    }
    if(_date.length == 1){
        _date = "0"+String(date.getDate());
    }

    return (date.getFullYear() + month + _date)
}

// ------------------------------------------------------
//                         공통
// ------------------------------------------------------
function insertComma(int){
    return (String(int).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'))
}

// ------------------------------------------------------
//                         GFF 검색
// ------------------------------------------------------
function onChangeGff(e){

    if(e.value.length < 4){
        alert("검색어를 4글자 이상 입력해주세요");
    }

    var stackAniEls = document.querySelectorAll(".stackAni");
    for(var i = 0 ; i < stackAniEls.length ; i++){
        stackAniEls[i].classList.remove("stackAni")
    }

    if(!e.value){return}
    var _searchValue = []


    var searchCount = 0;
	var searchKey = e.value.toUpperCase();

    for(var key in gffData){
        

        if(key.toUpperCase().includes(searchKey)){

            if(!lengthData[gffData[key].chr]){continue}

            _searchValue.push(key);
            /*
            if(++searchCount > 100){
                break;
            }
            */
        }
    }
    
    
    if(_searchValue.length == 0){
        alert("검색결과가 없습니다.");
        return;
    }

    searchValue = _searchValue

    initChart();
    if(currentClick=="C"||currentClick=="Chr"){
        drawChartName(currentClick);
    }else{
        drawChart(currentClick);
    }

    // for(var i = 0 ; i < searchValue.length ; i++){
    //     var searchColumn = document.querySelector("[data-column="+gffData[searchValue[i]].chr+"]");
    //     if(searchColumn){
    //         searchColumn.classList.add("stackAni");
    //     }
    // }

}


function readLenFile()
{
    var file = document.getElementsByClassName("serverLen")[0].innerHTML;
    if(!file){return};

    var rawFile = new XMLHttpRequest();
    rawFile.open("GET", file, true);
    rawFile.onreadystatechange = function ()
    {
        if(rawFile.readyState === 4)
        {
            if(rawFile.status == 404){
                alert("Len파일을 찾을 수 없습니다.")
                console.error("Len file 404");
                return;
            }
            if(rawFile.status === 200 || rawFile.status == 0)
            {
                var allText = rawFile.responseText;

				//console.log("allText : ", allText);																		// allText : len파일에서 reponse받은 텍스트 데이터

                parsingData(allText);
            }
        }
    }
    rawFile.send(null);
}
function readGffFile()
{
    var file = document.getElementsByClassName("serverGff")[0].innerHTML;
    if(!file){return};
    var rawFile = new XMLHttpRequest();
    rawFile.open("GET", file, true);
    rawFile.onreadystatechange = function ()
    {
        if(rawFile.readyState === 4)
        {
            if(rawFile.status == 404){
                alert("Gff파일을 찾을 수 없습니다.")
                console.error("Len file 404");
                return;
            }
            if(rawFile.status === 200 || rawFile.status == 0)
            {
                var allText = rawFile.responseText;
				//console.log("allText : ", allText);																		// allText : gff파일에서 reponse받은 텍스트 데이터
                parcingGff(allText);
            }
        }
    }
    rawFile.send(null);
}

readGffFile();
readLenFile();