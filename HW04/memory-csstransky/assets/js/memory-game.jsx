import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<Starter />, root);
}

class Starter extends React.Component {
  constructor(props) {
    super(props);

		// Assign random varibles
		//	Make array of strings [A, A, B, B, ...], just do it dumb way for now
		//	for(i=0; i<length; i++)
		//		tempVal = pop array of strings
		//		randomIndex = randFunc(0, end of array)
		//
		//		if panel_list[randomIndex] is not empty
		//			
		//			while(spotFilled)
		//				randomIndex += 1
		//				if randomIndex > panel_list.length
		//					randomIndex = 0
		//				
		//				if panel_list[randomIndex] is empty
		//					panel_list[randomIndex].value = tempVal
		//					spotFilled = true
		//
		//		else if value is empty
		//			panel_list[randomIndex].value = tempVal


		// When panel is clicked, 
		//	check if compare_string is empty:
		//		if empty and panel is hidden, 
		//			show that panel
		//			compare_string = value of that panel
		//		else not empty and panel is hidden,
		//			show that panel
		//
		//			if compare_string and that value of panel are the same
		//				do nothing?
		//			else they're not the same
		//				short delay (3 sec?)
		//				hide panel
		//				hide compare_string panel
		//
		//			compare_string = "" again
		
		this.state = {
			panel_list: _.shuffle("AABBCCDDEEFFGGHH")
        .map(function (letter) {
				  return { value: letter, hidden: true }; 
        }),
      compare_string: ""
		}
  }

  swap(_ev) {
    let state1 = _.assign({}, this.state, { left: !this.state.left });
    this.setState(state1);
  }

  hax(_ev) {
    alert("hax!");
  }

  render() {

		let y = this.state.panel_list.map(function (list) { 
				return <div className="column">
            <div class="panel">
              <p>x is {list.value}</p>
            </div>
					</div>;
				});
/*
		let rows = this.state.panel_list.map(function (x) {
		  return <div className="row">
		});
*/
		return <div>{y}</div>;
  }
}

