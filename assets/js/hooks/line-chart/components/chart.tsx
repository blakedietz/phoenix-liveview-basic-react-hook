import React from "react";
import * as Scale from "@visx/scale";
import { max, min } from "d3-array";
import { GradientPinkRed, GradientPurpleOrange } from "@visx/gradient";
import { Axis } from "@visx/axis";
import { LinePath, Circle } from "@visx/shape";
import {
  curveNatural,
  curveBasis,
  curveStep,
  curveStepAfter,
  curveStepBefore,
} from "@visx/curve";
import { LinearGradient, RadialGradient } from "@visx/gradient";
import { useTooltip, useTooltipInPortal, TooltipInPortal } from "@visx/tooltip";
import { localPoint } from "@visx/event";

const green = "#e5fd3d";
export const blue = "#aeeef8";
const darkgreen = "#dff84d";
export const background = "#744cca";
const pink = "#f6c431";
const darkbackground = "#603FA8";
const strokeColor = "#744cca";

const styleTickLabel = () => ({
  fill: pink,
  stroke: "none",
  fontSize: 10,
  textAnchor: "middle",
});

const LineChart = ({
  width: outerWidth = 600,
  height: outerHeight = 400,
  moods,
}) => {
  const {
    tooltipData,
    tooltipLeft,
    tooltipTop,
    tooltipOpen,
    showTooltip,
    hideTooltip,
  } = useTooltip();

  // If you don't want to use a Portal, simply replace `TooltipInPortal` below with
  // `Tooltip` or `TooltipWithBounds` and remove `containerRef`
  const { containerRef, TooltipInPortal } = useTooltipInPortal({
    // use TooltipWithBounds
    detectBounds: true,
    // when tooltip containers are scrolled, this will correctly update the Tooltip position
    scroll: true,
  });

  const handleMouseOver = (datum) => (event) => {
    const coords = localPoint(event.target.ownerSVGElement, event);
    console.log(datum);
    showTooltip({
      tooltipLeft: coords.x,
      tooltipTop: coords.y,
      tooltipData: datum,
    });
  };

  const margins = {
    top: 20,
    left: 20,
    right: 20,
    bottom: 20,
  };

  const minX = min(moods, ({ inserted_at }) => inserted_at);
  const maxX = max(moods, ({ inserted_at }) => inserted_at);

  const getX = (d) => d.inserted_at;
  const getY = (d) => d.rating;

  const width = outerWidth - margins.left - margins.right;
  const height = outerHeight - margins.top - margins.bottom;

  const xScale = Scale.scaleTime({
    domain: [minX, maxX],
    range: [0, width],
  });

  const yScale = Scale.scaleLinear({
    domain: [1, 10],
    range: [height, 0],
  });

  return (
    <>
      <svg ref={containerRef} width={outerWidth} height={outerHeight}>
        <GradientPinkRed id="line-gradient" />
        <GradientPurpleOrange id="purple-orange" />
        <rect
          width={outerWidth}
          height={outerHeight}
          fill="url(#line-gradient)"
          rx={14}
        />
        <g transform={`translate(${margins.left}, ${margins.top})`}>
          <Axis
            orientation="left"
            scale={yScale}
            stroke={pink}
            strokeWidth={1}
            tickLabelProps={styleTickLabel}
            tickStroke={pink}
          />
          <Axis
            top={height}
            orientation="bottom"
            scale={xScale}
            stroke={pink}
            strokeWidth={1}
            tickLabelProps={styleTickLabel}
            tickStroke={pink}
          />
          <LinePath
            curve={curveStepAfter}
            data={moods}
            stroke={pink}
            x={(d) => xScale(getX(d))}
            y={(d) => yScale(getY(d))}
            strokeWidth={2}
          />
          {moods.map((mood, index) => (
            <Circle
              key={index}
              onMouseOver={handleMouseOver(mood)}
              onMouseOut={hideTooltip}
              fill="url(#purple-orange)"
              cx={xScale(getX(mood))}
              cy={yScale(getY(mood))}
              r={3}
            />
          ))}
        </g>
      </svg>
      {tooltipOpen && (
        <TooltipInPortal
          // set this to random so it correctly updates with parent bounds
          key={Math.random()}
          top={tooltipTop}
          left={tooltipLeft}
        >
          {tooltipData.notes}
        </TooltipInPortal>
      )}
    </>
  );
};

export default LineChart;
