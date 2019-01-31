import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<Starter />, root);
}

class Starter extends React.Component {
  constructor(props) {
    super(props);
		{/* You'll get this working one day
			this.state = {
			panel_grid: [
				// Rows
				for (let i=0; i<num_of_rows; i++) {
					let row = []
					// Columns
					for (let j=0; j<num_of_cols; j++) {
						row.push(value: "A", hidden: true)
					}
				}
			]
		},
		*/}

		{/* This will only be for debugging
    this.state = { 
			panel_grid: [
				{ panel_row1: [ { value: "A", hidden: true },
												{ value: "A", hidden: true },
												{ value: "B", hidden: true },
												{ value: "B", hidden: true }
											] },
				{ panel_row2: [ { value: "C", hidden: true },
												{ value: "C", hidden: true },
												{ value: "D", hidden: true },
												{ value: "D", hidden: true }
											] },
				{ panel_row3: [ { value: "E", hidden: true },
												{ value: "E", hidden: true },
												{ value: "F", hidden: true },
												{ value: "F", hidden: true }
											] },
				{ panel_row4: [ { value: "G", hidden: true },
												{ value: "G", hidden: true },
												{ value: "H", hidden: true },
												{ value: "H", hidden: true }
											] }
			]
		};
		*/}
		this.state = {
			items: [
				{ value: "A", hidden: true },
				{ value: "B", hidden: false }
			]
		};
  }

  swap(_ev) {
    let state1 = _.assign({}, this.state, { left: !this.state.left });
    this.setState(state1);
  }

  hax(_ev) {
    alert("hax!");
  }

  render() {
    let button = <div className="column" onMouseMove={this.swap.bind(this)}>
      <p><button onClick={this.hax.bind(this)}>Click Me</button></p>
    </div>;

    let blank = <div className="column">
      <p>Nothing here.</p>
    </div>;

    if (this.state.left) {
      return <div className="row">
        {button}
        {blank}
      </div>;
    }
    else {
      return <div className="row">
        {blank}
        {button}
      </div>;
    }
  }
}

