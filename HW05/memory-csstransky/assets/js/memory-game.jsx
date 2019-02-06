import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
  ReactDOM.render(<Memory channel={channel} />, root);
}

class Memory extends React.Component {
  constructor(props) {
    super(props);

		this.channel = props.channel;
		this.state = {
      panel_list: ["a"],
      compare_string: "",
      score: 0,
    };
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.got_view.bind(resp);
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});

		// TODO: change ".receive("ok", (resp) ..." into .receive("ok", resp ..."

  }

  got_view(view) {
    console.log("new view", view);
    this.setState(view.game);
  }

	flip(clicked_panel_index, _ev) {
		this.channel.push("flip", { panel_index: clicked_panel_index })
			.receive("ok", (resp) => { this.setState(resp.game); });
		// TODO: change ".receive("ok", (resp) ..." into .receive("ok", resp ..."
	}

 	reset() {
		this.channel.push("reset").receive("ok", (resp) => {
			this.setState(resp.game);
		});
		// TODO: change ".receive("ok", (resp) ..." into .receive("ok", resp ..."
	}

  render() {
		let gameboard = _.map(
			_.chunk(this.state.panel_list, 4), (rowOfTiles, rowNum) => {
				return <div className="row" key={rowNum}>{
						_.map(rowOfTiles, (panel, colNum) => {
							let ll = rowNum * 4 + colNum;
							return <div className="column" key={ll}>
								<div className="panel"
										 onClick={this.flip.bind(this, ll)}>
								<RenderPanel value={panel.value}
														 hidden={panel.hidden} />
								</div>
							</div>;
							})
						}</div>
				});

		return <div>SCORE: {this.state.score}
				{gameboard}
				<p><button onClick={this.reset.bind(this)}>Restart</button></p>
			</div>;
  }
}

function RenderPanel({value, hidden}) {
	if (hidden) {
		return <p></p>;
	}
	else {
		return <p>{value}</p>;
	}
}
