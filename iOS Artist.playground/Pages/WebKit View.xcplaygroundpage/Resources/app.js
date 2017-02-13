function show(string) {
    
    if(!document.body) return;
    
    if (document.querySelectorAll('.smiley').length <= 0) {
        var styleNode =  document.createElement('style');
        styleNode.textContent = `.smiley \
                { display: block; \
                    float: left; \
                    width: 80px; \
                   height: 80px; \
                 overflow: hidden; \
                font-size: 44pt; \
              font-family: sans-serif; \
                    color: gray; \
                  opacity: 0; \
               transition: opacity 0.333s ease-in; \
            }`;
        document.documentElement.appendChild(styleNode);
    }
    var arr = emojiStringToArray(string);
    arr.forEach((e, i)=> { appendChar(e, i); });
}
// @Source: http://stackoverflow.com/questions/24531751/how-can-i-split-a-string-containing-emoji-into-an-array
function emojiStringToArray (str) {
  split = str.split(/([\uD800-\uDBFF][\uDC00-\uDFFF])/);
  arr = [];
  for (var i=0; i<split.length; i++) {
    char = split[i]
    if (char !== "") {
      arr.push(char);
    }
  }
  return arr;
}
function appendChar(char, index) {
    if (index < 0) return;

    var div = document.createElement('div');
    var text = document.createTextNode(char);
    div.className = "smiley";
    div.appendChild(text);
    document.body.appendChild(div);
    
    setTimeout(()=>{ div.style.opacity = 1; }, index*200);
}

// window.onload = (e)=> { show('🏀🎱🎾🏓棋♞'); };