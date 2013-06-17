/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 6/17/13
 * Time: 10:35 AM
 * To change this template use File | Settings | File Templates.
 */
$(function(){
        $.get('http://localhost:3000/getTimeAnalysis?eventID=test',function(data){
            var result = JSON.parse(data);
            for(var percep in result){
                if(percep == 'startTime'|| percep=='endTime'){
                  continue;
                }
                $("#perceptions").append($("<option />").val(percep).text(percep));
            };
            $("#perceptions").append($("<option />").val("stacked").text("Stacked Graph"));
            $("#perceptions").change(function (){
                var selected = $('#perceptions').val();
                if(selected == "stacked"){
                    stackedGraph(500000);
                    return;
                }
                chart(selected,500000);
            });

            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
            chart = function(type,interval){
                var series = [{
                    name:type,
                    pointInterval: interval,
                    pointStart: result.startTime,
                    data: result[type],
                }]
                $('#TimeAnalysis').highcharts({
                chart: {
                    type: 'area',
                    zoomType: 'x',
                },
                title: {
                    text: 'Time Analysis Graph'
                },
                legend: {
                    layout: 'vertical',
                    align: 'left',
                    verticalAlign: 'top',
                    x: 150,
                    y: 100,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor: '#FFFFFF'
                },
                xAxis: {
                    type: 'datetime',
                    //maxZoom:  24 * 3600000, // fourteen days
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    title: {
                        text: 'Accumilated Perception Count',
                        min: 0,
                        startOnTick: false
                    }
                },
                tooltip: {
                    shared: true,
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    area: {
                        marker: {
                            enabled: false
                        },
                    }
                },
                series: series
            });
        };

        stackedGraph = function(interval){
                 var series = new Array();
                 for(var name in result){
                     if(name == 'startTime'|| name=='endTime'){
                         continue;
                     };
                     var ob = new Object();
                     ob.name = name;
                     ob.data = result[name];
                     ob.pointInterval = interval;
                     ob.pointStart = result.startTime;
                     series.push(ob);
                 }
                $('#TimeAnalysis').highcharts({
                    chart: {
                        type: 'area',
                        zoomType: 'x',
                    },
                    title: {
                        text: 'Perception Time Graph'
                    },
                    xAxis: {
                        type: 'datetime',
                        tickmarkPlacement: 'on',
                        title: {
                            enabled: false
                        }
                    },
                    yAxis: {
                        title: {
                            text: 'Count'
                        },
                        labels: {
                            formatter: function() {
                                return this.value;
                            }
                        }
                    },
                    tooltip: {
                        shared: true,
                    },
                    plotOptions: {
                        area: {
                            stacking: 'normal',
                            lineColor: '#666666',
                            lineWidth: 1,
                            marker: {
                                lineWidth: 1,
                                lineColor: '#666666'
                            }
                        }
                    },
                    series: series
                });
        }

     });
});