import React from "react";
import {createRoot} from "react-dom/client";
import ParentSize from "@visx/responsive/lib/components/ParentSizeModern";
import Chart from "./components/chart";

const LineChart = {
    mounted() {
        const root = createRoot(this.el);
        const data = JSON.parse(this.el.dataset.moods).map(
            ({rating, inserted_at, notes}) => ({
                rating,
                inserted_at: new Date(inserted_at),
                notes,
            })
        );
        root.render(
            <ParentSize>
                {({width, height}) => (
                    <Chart moods={data} width={width} height={height}/>
                )}
            </ParentSize>
        );
    },
};

export default LineChart;
