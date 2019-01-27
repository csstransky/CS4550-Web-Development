(function () {
  "use strict";
  var storedValue = "";
  var operatorOn = false;
  
  function onNumberButtonPress(number) {
    if (operatorOn || document.getElementById("output").innerHTML == "0") {
      document.getElementById("output").innerHTML = number;
      operatorOn = false;
    }
		else {
      document.getElementById("output").innerHTML += number;
    }
  }

  function onOperatorButtonPress(operator) {
		// Concatting to a null value doesn't in JavaScript, have to do this
		if (storedValue == "") {
			storedValue = document.getElementById("output").innerHTML + operator;    
		}
    // When you want to switch to minus if you clicked plus, just replaces it
		else if (operatorOn) {
      storedValue = storedValue.slice(0, -1); // removes last char
      storedValue += operator;
    }
		else {
			storedValue += document.getElementById("output").innerHTML + operator; 
		}
		console.log("storedValue: " + storedValue);
		operatorOn = true;
	}

	// Works exactly like addition, but also shows the equation so far as well
  function onPlusEqualsButtonPress() {
		onOperatorButtonPress("+");	
		document.getElementById("output").innerHTML 
			= eval(storedValue.slice(0, -1));
  }

  function onClearButtonPress() {
    storedValue = "";
    document.getElementById("output").innerHTML = "0";
		console.log("storedValue: " + storedValue);
  }

  function onDecimalButtonPress() {
		// Will only allow for a decimal to be input if there isn't one already
		// Good: 22.33
		// Bad: 22.3.3
		if (document.getElementById("output").innerHTML.indexOf(".") == -1) {
			document.getElementById("output").innerHTML += "."
		}
	}

  function init() {
    console.log("Begin loading script");

    var numberButtons = document.getElementsByClassName("numberButton");
    for (let i = 0; i < numberButtons.length; i++) {
      numberButtons[i].addEventListener("click", 
      function() { 
        onNumberButtonPress(numberButtons[i].value); 
      });
    }
    
    // Includes all operators EXCEPT +/=
    var operatorButtons = document.getElementsByClassName("operatorButton");
    for (let i = 0; i < operatorButtons.length; i++) {
      operatorButtons[i].addEventListener("click",
      function() { 
        onOperatorButtonPress(operatorButtons[i].value); 
      });
    }

    var buttonPlusEquals = document.getElementById("buttonPlusEquals");
    var buttonClear = document.getElementById("buttonClear");
    var buttonDecimal = document.getElementById("buttonDecimal");

		buttonPlusEquals.addEventListener("click",
      function () {
        onPlusEqualsButtonPress();
      } );

    buttonClear.addEventListener("click",
      function () {
        onClearButtonPress();
      } );

		buttonDecimal.addEventListener("click",
			function () {
				onDecimalButtonPress();
			} );
    console.log("Done loading script");
	}
  
	window.addEventListener("load", init, false);
})();


