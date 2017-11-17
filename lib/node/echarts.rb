require "node/echarts/version"
require "json"

module Node
  module Echarts
    # Generate chart picture
    #
    # Example:
    #  >> chart("/home/foo/sample.png", {titile: {text: 'T1'},
    #                          xAxis: ['c'],
    #                          series: [{type: 'bar', data: [100]}]
    #                          },
    #           400, 400)
    #
    #  Arguments:
    #    path: (string)
    #    data: (hash)
    #    width: integer
    #    height: integer
    def                        self.chart(path, data, width=400, height=400)
      cmd_str = "var echarts = require('echarts'); var Canvas = require('canvas'); var fs = require('fs'); #{@theme}; echarts.setCanvasCreator(function () { var canvas = new Canvas(128, 128); return canvas; }); var chart = echarts.init(new Canvas(#{width}, #{height}), 'infographic'); chart.setOption(#{data.to_json.gsub("\"", "'")}); fs.writeFileSync('#{path}', chart.getDom().toBuffer()); process.exit()"
      `node -e "#{cmd_str}"`
    end

    # Register echarts theme by file
    #
    # Example:
    #  >> Node::Echarts.register_theme("/home/infographic")
    #
    # Arguments:
    #  path: (string)
    def self.register_theme(path)
      @theme = File.read(path).
        gsub(/\/\/.*$/, '').  # remove comment
        gsub("\n", "").       # remove \n
        gsub(/\s+/, " ").     # compact blank
        gsub("\"", "'")       # replace " with '
    end
  end
end
