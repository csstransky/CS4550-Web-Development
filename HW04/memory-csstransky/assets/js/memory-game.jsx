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
		//	if panel.hidden == true
		//		if compare_string == empty 
		//			panel.hidden = false
		//			compare_string = panel.value
		//
		//		else compare_string != empty
		//			show that panel
		//
		//			if compare_string != panel.value
		//				short delay (3 sec?)
		//				panel.hidden = true
		//				hide compare_string panel
		//
		//			compare_string = ""
		
		this.state = {
			panel_list: _.shuffle("AABBCCDDEEFFGGHH")
        .map(function (letter) {
				  return { value: letter, hidden: true }; 
        }),
      compare_string: ""
		}
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

		let compare_panel_index = this.state.panel_list
			.findIndex((panel, jj) => {
				if (panel.value === this.state.compare_string && !panel.hidden) {
					return jj;
				}
		});
		let swap_back_last_panel = false;
		let state1 = this.state.panel_list
			.map((panel, jj) => { 
				if (jj === ii && panel.hidden) {
					console.log("Found panel: " + jj);
					if (compare_string == "") {
						return {...panel, hidden: false}
					}
					else if (compare_string != panel.value) {					
						/*
						window.setTimeout(function () {
							console.log("TIMEOUT?", this);
							let state3 = this.state.panel_list.map((panel3, kk) => {
								if (jj === kk) {
									return {...panel3, hidden: false }
								}
								else {
									return panel3;
								}
							});
							this.setState({
								panel_list: state3
							})
						}.bind(this), 3000);
						*/
						// Show panel here
						// Add delay here before hiding agai
						console.log("ARE YOU OUT THERE?")
						swap_back_last_panel = true;
						return {...panel, hidden: false }	
					}
					else {
						return panel;
					}
				}
				else {
					return panel;
			}});
		
		// Giant mess used to try an swap back the compare panel to hidden
		let state2 = state1;
		console.log(state2);
		/*
		if (swap_back_last_panel) {
			let compare_panel = { value: compare_string, hidden: false }; 

			// Weird bug where the 0 element will return -1 instead
			if (compare_panel_index == -1) {
				compare_panel_index = 0;
			}
			console.log("compare_panel_index is " + compare_panel_index);
			state2 = state1.map((panel, jj) => {
				if (jj === compare_panel_index) {
					console.log("Changing this pannel to hidden " + jj);
					return {...panel, hidden: true};
				}
				else {
					return panel;
				}
			});
		}
*/

		// Fixes bug where you can't match the same exact panel
		if (ii != compare_panel_index) {
			// First block to compare click
			if (this.state.panel_list[ii].hidden && compare_string == "") {
				this.setState({
					panel_list: state2,
					compare_string: this.state.panel_list[ii].value
				});
			} 
			// No Match found
			else if (this.state.panel_list[ii].hidden && compare_string != "") {	
				this.setState({
					panel_list: state2,
					compare_string: ""
				});
				window.setTimeout(function () {
					console.log("TIMEOUT?", this);
					let state3 = this.state.panel_list.map((panel3, kk) => {
						if (compare_panel_index === kk) {
							return {...panel3, hidden: true}
						}
						else {
							return panel3;
						}
					});
					let state4 = state3.map((panel4, jj) => { 
						if (jj === ii) {
							return {...panel4, hidden: true}
						}
						else {
							return panel4
						}
					});

					this.setState({
						panel_list: state4,
						compare_string: ""
					});
				}.bind(this), 1000);
			
			/*
				this.setState({
					panel_list: state2,
					compare_string: ""
				});

				*/
			}
			// Match found
			else {
				this.setState({
					panel_list: state2,
				});
			}
		}
	}

 	reset() {
		let state1 = {
			panel_list: _.shuffle("AABBCCDDEEFFGGHH")
				.map(function (letter) {
					return { value: letter, hidden: true }; 
				}),
			compare_string: ""
		}
		this.setState(state1);
	}

  render() {
	/*
	let dog = this.state.panel_list.map((panel, ii) => { 
		<div className="row">
			<div className="column">
				<p>LOL</p>

			</div>
			<div className="column">
				<p>LOL</p>
				
			</div>
			<div className="column">
				<p>LOL</p>

		
			</div>
			<div className="column">
				<p>LOL</p>
						
			</div>
		</div>

		<div className="row">
			<div className="column">
				<p>LOL</p>
			
			</div>
			<div className="column">
				<p>LOL</p>
			
			</div>
			<div className="column">
				<p>LOL</p>
		
			</div>
			<div className="column">
				<p>LOL</p>
			
			</div>
		</div>

		<div className="row">
			<div className="column">

			</div>
			<div className="column">
			
			</div>
			<div className="column">
			
			</div>
			<div className="column">
			
			</div>
		</div>
		<div className="row">
			<div className="column">

			</div>
			<div className="column">
			
			</div>
			<div className="column">
			
			</div>
			<div className="column">
				<div className="panel" onClick={this.flip.bind(this, 15)}>
					<RenderPanel value={this.state.panel[15].value}
											 hidden={this.state.panel[15].hidden} />
				</div>
			</div>
		</div>
	};
*/
		let yy = _.map(_.chunk(this.state.panel_list, 4), (rowOfTiles, rowNum) => {
		return <div className="row" key={rowNum}>	{
				_.map(rowOfTiles, (panel, colNum) => {
					let ll = rowNum * 4 + colNum;
					return <div className="column" key={ll}>
						<p>{console.log("panel", panel, "ll", ll)}</p>
						<div className="panel" 
							 	 onClick={this.flip.bind(this, ll)}>
						<RenderPanel value={panel.value}
												 hidden={panel.hidden} />
						</div>					
					</div>;
					})
				}
			</div>
		});

		let y = this.state.panel_list.map((panel, ii) => { 
				return <div className="column" key={ii}>
						<div className="panel" 
								 onClick={this.flip.bind(this, ii)}>
							<RenderPanel value={panel.value}
													 hidden={panel.hidden} />
            </div>
					</div>;
				});

		return <div>Compare String: {this.state.compare_string} 
				{yy}
				<p><button onClick={this.reset.bind(this)}>Restart</button></p>
			</div>;
  }
}



function RenderPanel({value, hidden}) {
//	console.log("Render: value " + value + " hidden " + hidden);
	
	if (hidden) {
		return <p></p>;
	}
	else {
		return <p>{value}</p>;
	}
}
