require "test_helper"

class Node::EchartsTest < Minitest::Test
  def setup
    path = File.expand_path('../', __FILE__)
    @echart_picture_path = File.join(path, 'chart.png')
    @echart_theme_picture_path = File.join(path, 'theme_chart.png')
    @theme_path = File.join(path, 'infographic.js')
  end
  def test_that_it_has_a_version_number
    refute_nil ::Node::Echarts::VERSION
  end

  def test_it_generate_picture
    Node::Echarts.chart(@echart_picture_path, {
      title: {
        text: '代码提交次数',
        textStyle: {
          fontSize: 18,
          fontWeight: 'lighter',
          color: '#333'
        }
      },
      tooltop: {
        trigger: 'axis'
      },
      xAxis: {
        data: ["背锅侠"]
      },
      yAxis: {},
      series: [{
        type: 'bar',
        barWidth: 40,
        itemStyle: {
          normal: {
            label: {show: true, position: 'top'}
          }
        },
        data: [100]
      }]
    })
    assert File.exist?(@echart_picture_path), "#{@echart_picture_path} generate failed!"
  end

  def test_it_generate_picture_with_theme
    Node::Echarts.register_theme(@theme_path)
    Node::Echarts.chart(@echart_theme_picture_path, {
      title: {
        text: '代码提交次数',
        textStyle: {
          fontSize: 18,
          fontWeight: 'lighter',
          color: '#333'
        }
      },
      tooltop: {
        trigger: 'axis'
      },
      xAxis: {
        data: ["背锅侠"]
      },
      yAxis: {},
      series: [{
        type: 'bar',
        barWidth: 40,
        itemStyle: {
          normal: {
            label: {show: true, position: 'top'}
          }
        },
        data: [100]
      }]
    }, 600, 600)
    assert File.exist?(@echart_theme_picture_path), "#{@echart_theme_picture_path} generate failed!"
  end

  def teardown
    File.delete(@echart_theme_picture_path)
    File.delete(@echart_picture_path)
  end
end
