
$( document ).ready(function() {
  var w = 600;
  var h = 250;

  var dataset = getHistogramData();
  
  var xScale = d3.scale.ordinal()
  				.domain(d3.range(dataset.length))
  				.rangeRoundBands([0, w], 0.05); 

  var yScale = d3.scale.linear()
  				.domain([0, d3.max(dataset, function(d) {return d.value;})])
  				.range([0, h]);

  var key = function(d) {
  	return d.key;
  };

  var tip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-10, 0])
    .html(function(d) {
      return "<strong>Sentiment:</strong> <span style='color:red'>" + d.tip + "</span>";
    })

  //Create SVG element
  var svg = d3.select("#thebar .chart")
  			.append("svg")
  			.attr("width", w)
  			.attr("height", h);
  
  svg.call(tip);

  //Create bars
  svg.selectAll("rect")
     .data(dataset, key)
     .enter()
     .append("rect")
     .attr("x", function(d, i) {
  		return xScale(i);
     })
     .attr("y", function(d) {
  		return h - yScale(d.value);
     })
     .attr("width", xScale.rangeBand())
     .attr("height", function(d) {
  		return yScale(d.value);
     })
     .attr("fill", function(d) {
  		return "rgb(0, 0, " + (d.value * 10) + ")";
     })
      .on('mouseover', tip.show)
      .on('mouseout', tip.hide)

  //Create labels
  svg.selectAll("text")
     .data(dataset, key)
     .enter()
     .append("text")
     .text(function(d) {
  		return d.value;
     })
     .attr("text-anchor", "middle")
     .attr("x", function(d, i) {
  		return xScale(i) + xScale.rangeBand() / 2;
     })
     .attr("y", function(d) {
  		return h - yScale(d.value) + 14;
     })
     .attr("font-family", "sans-serif") 
     .attr("font-size", "11px")
     .attr("fill", "white");
     
  var sortOrder = false;
  var sortBars = function () {
      sortOrder = !sortOrder;
      
      sortItems = function (a, b) {
          if (sortOrder) {
              return a.value - b.value;
          }
          return b.value - a.value;
      };

      svg.selectAll("rect")
          .sort(sortItems)
          .transition()
          .delay(function (d, i) {
          return i * 50;
      })
          .duration(1000)
          .attr("x", function (d, i) {
          return xScale(i);
      });

      svg.selectAll('text')
          .sort(sortItems)
          .transition()
          .delay(function (d, i) {
          return i * 50;
      })
          .duration(1000)
          .text(function (d) {
          return d.value;
      })
          .attr("text-anchor", "middle")
          .attr("x", function (d, i) {
          return xScale(i) + xScale.rangeBand() / 2;
      })
          .attr("y", function (d) {
          return h - yScale(d.value) + 14;
      });
  };
  // Add the onclick callback to the button
  d3.select("#sort").on("click", sortBars);
  d3.select("#reset").on("click", reset);
  function randomSort() {

  	
  	svg.selectAll("rect")
          .sort(sortItems)
          .transition()
          .delay(function (d, i) {
          return i * 50;
      })
          .duration(1000)
          .attr("x", function (d, i) {
          return xScale(i);
      });

      svg.selectAll('text')
          .sort(sortItems)
          .transition()
          .delay(function (d, i) {
          return i * 50;
      })
          .duration(1000)
          .text(function (d) {
          return d.value;
      })
          .attr("text-anchor", "middle")
          .attr("x", function (d, i) {
          return xScale(i) + xScale.rangeBand() / 2;
      })
          .attr("y", function (d) {
          return h - yScale(d.value) + 14;
      });
  }
  function reset() {
  	svg.selectAll("rect")
  		.sort(function(a, b){
  			return a.key - b.key;
  		})
  		.transition()
          .delay(function (d, i) {
          return i * 50;
  		})
          .duration(1000)
          .attr("x", function (d, i) {
          return xScale(i);
  		});
  		
  	svg.selectAll('text')
          .sort(function(a, b){
  			return a.key - b.key;
  		})
          .transition()
          .delay(function (d, i) {
          return i * 50;
      })
          .duration(1000)
          .text(function (d) {
          return d.value;
      })
          .attr("text-anchor", "middle")
          .attr("x", function (d, i) {
          return xScale(i) + xScale.rangeBand() / 2;
      })
          .attr("y", function (d) {
          return h - yScale(d.value) + 14;
      });
  };
});