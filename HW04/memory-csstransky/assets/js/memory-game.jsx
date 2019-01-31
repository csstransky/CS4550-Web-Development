import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<Starter />, root);
}

class Starter extends React.Component {
  constructor(props) {
    super(props);

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

	flip(ii, _ev) {
		console.log("show indse" + ii);
		let compare_string = this.state.compare_string;
		if (compare_string == "") {
			console.log("compare string is empty = " + compare_string);
		}
		else {
			console.log("compare string is here = " + compare_string);
		}
		let state1 = this.state.panel_list
			.map((panel, jj) => { 
			if (jj === ii) {
				return {...panel, hidden: !panel.hidden}
			}
			else {
				return panel;
			}});
		this.setState({
			panel_list: state1,
			compare_string: this.state.panel_list[ii].value
		});
	}

  render() {
		let y = this.state.panel_list.map((panel, ii) => { 
				return <div className="column" key={ii}>
            <div className="panel" 
								 onClick={this.flip.bind(this, ii)}>
							<p>{panel.hidden.toString()}</p>
							<p>index: {ii}</p>
							<RenderPanel value={panel.value}
													 hidden={panel.hidden} />
            </div>
					</div>;
				});
/*
		let rows = this.state.panel_list.map(function (x) {
		  return <div className="row">
		});
*/
		return <div>{this.state.panel_list[1].value} 
			{this.state.compare_string} {y}</div>;
  }
}

function RenderPanel({value}, {hidden}) {
	if (hidden) {
		return <p>hide</p>;
	}
	else {
		return <p>{hidden}no ide: {value}</p>;
	}
}
