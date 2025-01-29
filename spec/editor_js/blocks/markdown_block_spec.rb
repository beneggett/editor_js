# frozen_string_literal: true

RSpec.describe EditorJs::Blocks::MarkdownBlock do
  let(:valid_data1) do
    {
      type: 'markdown',
      data: {
        text: <<~MARKDOWN
          - nihao
          - zaijian

          #### 来投票
          * [ ] 投票
          * [x] 不投票

          ```javascript
          function hello() {
            console.log('hello')
          }

          <script>alert('js code')</script>
          ```
          ```html
          <h1>This is header</h1>
          ```

          <script>alert('js code error')</script>
          plain text

          |   字段 |   类型 |   描述 | |
          | ------ | ------ | ------ | --- |
          | identifier |

          ++新消息++

          **撒地方**

          *斜体*

          ~~这是啥~~
        MARKDOWN
      }
    }
  end

  context 'with valid data' do
    let(:markdown) { described_class.new(valid_data1) }

    it { expect(markdown).to be_valid }
    it do
      html = <<~HTML.strip
        <div class="editor_js--markdown"><ul>
        <li>nihao</li>
        <li>zaijian</li>
        </ul>
        <h4>来投票</h4>
        <ul>
        <li class="task-list-item"><input type="checkbox" disabled="" /> 投票</li>
        <li class="task-list-item"><input type="checkbox" checked="" disabled="" /> 不投票</li>
        </ul>
        <div class="highlighter-rouge language-javascript"><div class="highlight"><pre class="codehilite"><code><span style="color: #cf222e">function</span> <span style="color: #8250df">hello</span><span style="color: #24292f;background-color: #f6f8fa">()</span> <span style="color: #24292f;background-color: #f6f8fa">{</span>
          <span style="color: #24292f;background-color: #f6f8fa">console</span><span style="color: #24292f;background-color: #f6f8fa">.</span><span style="color: #8250df">log</span><span style="color: #24292f;background-color: #f6f8fa">(</span><span style="color: #0a3069">'</span><span style="color: #0a3069">hello</span><span style="color: #0a3069">'</span><span style="color: #24292f;background-color: #f6f8fa">)</span>
        <span style="color: #24292f;background-color: #f6f8fa">}</span>

        <span style="color: #0550ae">&lt;</span><span style="color: #24292f;background-color: #f6f8fa">script</span><span style="color: #0550ae">&gt;</span><span style="color: #8250df">alert</span><span style="color: #24292f;background-color: #f6f8fa">(</span><span style="color: #0a3069">'</span><span style="color: #0a3069">js code</span><span style="color: #0a3069">'</span><span style="color: #24292f;background-color: #f6f8fa">)</span><span style="color: #0550ae">&lt;</span><span style="color: #116329">/script</span><span style="color: #f6f8fa;background-color: #82071e">&gt;
        </span></code></pre></div></div>
        <div class="highlighter-rouge language-html"><div class="highlight"><pre class="codehilite"><code><span style="color: #116329">&lt;h1&gt;</span>This is header<span style="color: #116329">&lt;/h1&gt;</span>
        </code></pre></div></div>

        <p>plain text</p>
        <table>
        <thead>
        <tr>
        <th>字段</th>
        <th>类型</th>
        <th>描述</th>
        <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
        <td>identifier</td>
        <td></td>
        <td></td>
        <td></td>
        </tr>
        </tbody>
        </table>
        <p>++新消息++</p>
        <p><strong>撒地方</strong></p>
        <p><em>斜体</em></p>
        <p><del>这是啥</del></p>
        </div>
      HTML
      expect(markdown.render).to eq(html)
    end
    it { expect(markdown.plain).to eq(valid_data1[:data][:text].strip) }
  end
end
