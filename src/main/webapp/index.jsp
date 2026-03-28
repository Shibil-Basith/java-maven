<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Java Application Runner</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg:        #0d1117;
      --surface:   #161b22;
      --surface2:  #1c2128;
      --border:    #30363d;
      --border2:   #484f58;
      --text:      #c9d1d9;
      --muted:     #8b949e;
      --accent:    #388bfd;
      --accent-bg: #1f3a6e;
      --green:     #3fb950;
      --green-bg:  #1a3a22;
      --red:       #f85149;
      --red-bg:    #3d1a1a;
      --orange:    #d29922;
      --orange-bg: #3a2a10;
      --mono:      'Courier New', Courier, monospace;
      --sans:      -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--sans);
      font-size: 14px;
      min-height: 100vh;
      padding: 24px;
    }

    .app-wrapper {
      max-width: 900px;
      margin: 0 auto;
    }

    /* ── Header ── */
    .header {
      display: flex;
      align-items: center;
      gap: 14px;
      margin-bottom: 24px;
      padding-bottom: 16px;
      border-bottom: 1px solid var(--border);
    }
    .logo {
      width: 40px; height: 40px;
      background: var(--accent-bg);
      border: 1px solid var(--accent);
      border-radius: 8px;
      display: flex; align-items: center; justify-content: center;
      font-family: var(--mono);
      font-size: 14px;
      font-weight: bold;
      color: var(--accent);
    }
    .header-info h1 { font-size: 16px; font-weight: 600; color: #e6edf3; }
    .header-info p  { font-size: 12px; color: var(--muted); margin-top: 2px; }
    .server-badge {
      margin-left: auto;
      display: flex; align-items: center; gap: 6px;
      background: var(--green-bg);
      border: 1px solid #2ea043;
      border-radius: 20px;
      padding: 4px 12px;
      font-size: 12px;
      color: var(--green);
    }
    .dot { width: 7px; height: 7px; border-radius: 50%; background: var(--green); }

    /* ── Metrics ── */
    .metrics {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 12px;
      margin-bottom: 20px;
    }
    .metric {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: 14px 16px;
    }
    .metric-label {
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: 0.6px;
      color: var(--muted);
      margin-bottom: 6px;
    }
    .metric-value {
      font-family: var(--mono);
      font-size: 22px;
      color: #e6edf3;
    }
    .metric-sub {
      font-size: 11px;
      color: var(--muted);
      margin-top: 3px;
    }

    /* ── Panel ── */
    .panel {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 10px;
      margin-bottom: 16px;
      overflow: hidden;
    }
    .panel-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px 16px;
      border-bottom: 1px solid var(--border);
      background: var(--surface2);
    }
    .panel-title {
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.7px;
      color: var(--muted);
    }
    .panel-body { padding: 16px; }

    /* ── Form ── */
    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }
    .form-group { display: flex; flex-direction: column; gap: 5px; }
    .form-group.full { grid-column: 1 / -1; }
    .form-group label {
      font-size: 12px;
      color: var(--muted);
      font-weight: 500;
    }
    .form-group input,
    .form-group select {
      background: var(--surface2);
      border: 1px solid var(--border);
      border-radius: 6px;
      padding: 8px 10px;
      color: var(--text);
      font-size: 13px;
      font-family: var(--mono);
      outline: none;
      transition: border-color 0.15s;
      width: 100%;
    }
    .form-group input:focus,
    .form-group select:focus { border-color: var(--accent); }
    .form-group select option { background: var(--surface2); }

    /* ── Buttons ── */
    .btn-row {
      display: flex;
      gap: 8px;
      margin-top: 16px;
      padding-top: 14px;
      border-top: 1px solid var(--border);
    }
    .btn {
      padding: 8px 18px;
      border-radius: 6px;
      font-size: 13px;
      font-weight: 500;
      cursor: pointer;
      border: 1px solid transparent;
      transition: opacity 0.15s, transform 0.1s;
    }
    .btn:active { transform: scale(0.97); }
    .btn-run  { background: var(--accent); color: #fff; border-color: var(--accent); }
    .btn-run:hover { opacity: 0.88; }
    .btn-stop { background: transparent; color: var(--red); border-color: var(--red); }
    .btn-stop:hover { background: var(--red-bg); }
    .btn-clear { background: transparent; color: var(--muted); border-color: var(--border); }
    .btn-clear:hover { background: var(--surface2); color: var(--text); }
    .btn-deploy { background: var(--green-bg); color: var(--green); border-color: #2ea043; }
    .btn-deploy:hover { opacity: 0.85; }

    /* ── Status bar ── */
    .status-bar {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-top: 12px;
    }
    .status-dot { width: 8px; height: 8px; border-radius: 50%; }
    .status-dot.green  { background: var(--green); }
    .status-dot.orange { background: var(--orange); }
    .status-dot.red    { background: var(--red); }
    .status-text { font-size: 12px; color: var(--muted); font-family: var(--mono); }

    /* ── Console ── */
    .console {
      background: #010409;
      border-radius: 0 0 8px 8px;
      padding: 14px;
      min-height: 160px;
      max-height: 220px;
      overflow-y: auto;
      font-family: var(--mono);
      font-size: 12px;
      line-height: 1.9;
    }
    .console::-webkit-scrollbar { width: 6px; }
    .console::-webkit-scrollbar-track { background: transparent; }
    .console::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }

    .log-line { display: flex; gap: 10px; }
    .log-time  { color: #4a5568; min-width: 78px; }
    .log-level { min-width: 48px; }
    .lvl-info  { color: #388bfd; }
    .lvl-ok    { color: #3fb950; }
    .lvl-warn  { color: #d29922; }
    .lvl-error { color: #f85149; }
    .log-msg   { color: #adbac7; }

    /* ── stdin row ── */
    .stdin-row {
      display: flex;
      gap: 8px;
      padding: 10px 14px;
      border-top: 1px solid var(--border);
      background: var(--surface2);
    }
    .stdin-row input {
      flex: 1;
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 6px;
      padding: 7px 10px;
      color: var(--text);
      font-size: 12px;
      font-family: var(--mono);
      outline: none;
    }
    .stdin-row input:focus { border-color: var(--accent); }
    .stdin-btn {
      background: var(--accent-bg);
      color: var(--accent);
      border: 1px solid var(--accent);
      border-radius: 6px;
      padding: 7px 14px;
      font-size: 12px;
      cursor: pointer;
    }
    .stdin-btn:hover { opacity: 0.85; }

    /* ── Tomcat info ── */
    .info-grid {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 10px;
    }
    .info-item { }
    .info-key   { font-size: 11px; color: var(--muted); margin-bottom: 3px; }
    .info-val   { font-family: var(--mono); font-size: 13px; color: #e6edf3; }

    /* ── Footer ── */
    .footer {
      margin-top: 24px;
      text-align: center;
      font-size: 11px;
      color: var(--muted);
      border-top: 1px solid var(--border);
      padding-top: 14px;
    }

    @media (max-width: 600px) {
      .metrics { grid-template-columns: 1fr 1fr; }
      .form-grid { grid-template-columns: 1fr; }
      .form-group.full { grid-column: 1; }
      .info-grid { grid-template-columns: 1fr 1fr; }
    }
  </style>
</head>
<body>
<%
  String serverPort    = String.valueOf(request.getServerPort());
  String contextPath   = request.getContextPath();
  String serverInfo    = application.getServerInfo();
  String jvmVersion    = System.getProperty("java.version");
  String jvmVendor     = System.getProperty("java.vendor");
  long   maxMem        = Runtime.getRuntime().maxMemory()  / (1024 * 1024);
  long   usedMem       = (Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / (1024 * 1024);
  String buildNum      = (System.getenv("BUILD_NUMBER") != null) ? "#" + System.getenv("BUILD_NUMBER") : "#—";
  String jenkinsBuild  = (System.getenv("JOB_NAME")    != null) ? System.getenv("JOB_NAME")            : "local";
  String nowStr        = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

  // Handle form POST
  String runOutput     = "";
  String runError      = "";
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String action    = request.getParameter("action");
    String className = request.getParameter("className");
    String args      = request.getParameter("args");

    if ("run".equals(action) && className != null && !className.trim().isEmpty()) {
      try {
        Class<?> clazz  = Class.forName(className.trim());
        String[] argArr = (args != null && !args.trim().isEmpty())
            ? args.trim().split("\\s+") : new String[0];
        java.lang.reflect.Method main = clazz.getMethod("main", String[].class);
        main.invoke(null, (Object) argArr);
        runOutput = "main() executed successfully on class: " + className;
      } catch (ClassNotFoundException e) {
        runError = "ClassNotFoundException: " + e.getMessage();
      } catch (NoSuchMethodException e) {
        runError = "NoSuchMethodException: No public static main(String[]) found in " + className;
      } catch (Exception e) {
        runError = e.getClass().getSimpleName() + ": " + e.getMessage();
      }
    }
  }
%>

<div class="app-wrapper">

  <!-- Header -->
  <div class="header">
    <div class="logo">J</div>
    <div class="header-info">
      <h1>Java Application Runner</h1>
      <p>Apache Tomcat &middot; Jenkins CI &middot; Built-in / Slave Node</p>
    </div>
    <div class="server-badge">
      <div class="dot"></div>
      Tomcat Active
    </div>
  </div>

  <!-- Metrics -->
  <div class="metrics">
    <div class="metric">
      <div class="metric-label">Server Port</div>
      <div class="metric-value"><%= serverPort %></div>
      <div class="metric-sub">HTTP / Tomcat</div>
    </div>
    <div class="metric">
      <div class="metric-label">JVM Heap Used</div>
      <div class="metric-value"><%= usedMem %> MB</div>
      <div class="metric-sub">of <%= maxMem %> MB max</div>
    </div>
    <div class="metric">
      <div class="metric-label">Jenkins Build</div>
      <div class="metric-value"><%= buildNum %></div>
      <div class="metric-sub"><%= jenkinsBuild %></div>
    </div>
  </div>

  <!-- Run Panel -->
  <div class="panel">
    <div class="panel-header">
      <span class="panel-title">main() execution</span>
      <span class="panel-title" style="color:#388bfd;">POST &rarr; Tomcat</span>
    </div>
    <div class="panel-body">
      <form method="POST" action="<%= contextPath %>/index.jsp" id="runForm">
        <input type="hidden" name="action" value="run" />
        <div class="form-grid">
          <div class="form-group">
            <label>Fully Qualified Class Name</label>
            <input type="text" name="className"
              value="<%= request.getParameter("className") != null ? request.getParameter("className") : "com.example.App" %>"
              placeholder="com.example.YourMainClass" />
          </div>
          <div class="form-group">
            <label>Build Profile</label>
            <select name="profile">
              <option value="production"  <%= "production".equals(request.getParameter("profile"))  ? "selected" : "" %>>production</option>
              <option value="development" <%= "development".equals(request.getParameter("profile")) ? "selected" : "" %>>development</option>
              <option value="testing"     <%= "testing".equals(request.getParameter("profile"))     ? "selected" : "" %>>testing</option>
            </select>
          </div>
          <div class="form-group full">
            <label>Program Arguments (args[])</label>
            <input type="text" name="args"
              value="<%= request.getParameter("args") != null ? request.getParameter("args") : "--env=production --port=8080" %>"
              placeholder="space-separated arguments passed to main()" />
          </div>
          <div class="form-group">
            <label>JVM Options (reference)</label>
            <input type="text" name="jvmOpts"
              value="<%= request.getParameter("jvmOpts") != null ? request.getParameter("jvmOpts") : "-Xms128m -Xmx512m" %>"
              placeholder="-Xms128m -Xmx512m" />
          </div>
          <div class="form-group">
            <label>Context Path</label>
            <input type="text" name="ctxPath" value="<%= contextPath.isEmpty() ? "/" : contextPath %>" readonly style="color:var(--muted);" />
          </div>
        </div>

        <div class="btn-row">
          <button type="submit" class="btn btn-run">&#9654; Run main()</button>
          <button type="button" class="btn btn-stop"   onclick="stopSim()">&#9632; Stop</button>
          <button type="button" class="btn btn-clear"  onclick="clearConsole()">Clear log</button>
          <button type="button" class="btn btn-deploy" onclick="deployToTomcat()">&#8659; Deploy WAR</button>
        </div>

        <!-- Status -->
        <div class="status-bar">
          <div class="status-dot <%= (!runOutput.isEmpty()) ? "green" : (!runError.isEmpty()) ? "red" : "orange" %>"
               id="statusDot"></div>
          <span class="status-text" id="statusText">
            <% if (!runOutput.isEmpty()) { %>
              <%= runOutput %>
            <% } else if (!runError.isEmpty()) { %>
              ERROR &mdash; <%= runError %>
            <% } else { %>
              Ready &mdash; awaiting execution
            <% } %>
          </span>
        </div>
      </form>
    </div>
  </div>

  <!-- Console Output -->
  <div class="panel">
    <div class="panel-header">
      <span class="panel-title">Console output</span>
      <span class="panel-title" style="color:var(--muted);"><%= nowStr %></span>
    </div>
    <div class="console" id="console">
      <div class="log-line">
        <span class="log-time"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
        <span class="log-level lvl-info">INFO </span>
        <span class="log-msg">Tomcat <%= serverInfo %> initialized on port <%= serverPort %></span>
      </div>
      <div class="log-line">
        <span class="log-time"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
        <span class="log-level lvl-ok">OK   </span>
        <span class="log-msg">JVM <%= jvmVersion %> (<%= jvmVendor %>) &mdash; heap: <%= usedMem %>MB / <%= maxMem %>MB</span>
      </div>
      <div class="log-line">
        <span class="log-time"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
        <span class="log-level lvl-info">INFO </span>
        <span class="log-msg">Context path: <%= contextPath.isEmpty() ? "/" : contextPath %></span>
      </div>
      <% if (!runOutput.isEmpty()) { %>
      <div class="log-line">
        <span class="log-time"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
        <span class="log-level lvl-ok">OK   </span>
        <span class="log-msg"><%= runOutput %></span>
      </div>
      <% } %>
      <% if (!runError.isEmpty()) { %>
      <div class="log-line">
        <span class="log-time"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
        <span class="log-level lvl-error">ERROR</span>
        <span class="log-msg"><%= runError %></span>
      </div>
      <% } %>
      <div class="log-line" id="cursor">
        <span class="log-time" id="livetime"></span>
        <span class="log-level lvl-warn">WAIT </span>
        <span class="log-msg">Awaiting next execution...</span>
      </div>
    </div>
    <div class="stdin-row">
      <input type="text" id="stdinInput" placeholder="stdin &mdash; send input to running process..." />
      <button class="stdin-btn" onclick="sendStdin()">Send &#8629;</button>
    </div>
  </div>

  <!-- Tomcat Server Info -->
  <div class="panel">
    <div class="panel-header">
      <span class="panel-title">Server info</span>
    </div>
    <div class="panel-body">
      <div class="info-grid">
        <div class="info-item">
          <div class="info-key">Server</div>
          <div class="info-val"><%= serverInfo %></div>
        </div>
        <div class="info-item">
          <div class="info-key">Java Version</div>
          <div class="info-val"><%= jvmVersion %></div>
        </div>
        <div class="info-item">
          <div class="info-key">Java Vendor</div>
          <div class="info-val"><%= jvmVendor %></div>
        </div>
        <div class="info-item">
          <div class="info-key">OS</div>
          <div class="info-val"><%= System.getProperty("os.name") %> <%= System.getProperty("os.arch") %></div>
        </div>
        <div class="info-item">
          <div class="info-key">Context Path</div>
          <div class="info-val"><%= contextPath.isEmpty() ? "/" : contextPath %></div>
        </div>
        <div class="info-item">
          <div class="info-key">Server Time</div>
          <div class="info-val"><%= nowStr %></div>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <div class="footer">
    Apache Tomcat &middot; Jenkins CI &mdash; Java Application Runner &mdash; <%= nowStr %>
  </div>

</div>

<script>
  const cons = document.getElementById('console');

  function ts() {
    return new Date().toLocaleTimeString('en-GB',{hour:'2-digit',minute:'2-digit',second:'2-digit'});
  }

  function appendLog(level, msg, cls) {
    const line = document.createElement('div');
    line.className = 'log-line';
    line.innerHTML =
      '<span class="log-time">' + ts() + '</span>' +
      '<span class="log-level ' + cls + '">' + level.padEnd(5) + '</span>' +
      '<span class="log-msg">' + msg + '</span>';
    cons.insertBefore(line, document.getElementById('cursor'));
    cons.scrollTop = cons.scrollHeight;
  }

  function stopSim() {
    appendLog('WARN', 'Shutdown signal received (SIGTERM)', 'lvl-warn');
    setTimeout(() => appendLog('INFO', 'Tomcat graceful shutdown complete', 'lvl-info'), 600);
    document.getElementById('statusDot').className = 'status-dot red';
    document.getElementById('statusText').textContent = 'Stopped';
  }

  function clearConsole() {
    const cursor = document.getElementById('cursor');
    while (cons.firstChild && cons.firstChild !== cursor) cons.removeChild(cons.firstChild);
    appendLog('INFO', 'Console cleared', 'lvl-info');
  }

  function deployToTomcat() {
    appendLog('INFO', 'Initiating WAR deployment via Jenkins...', 'lvl-info');
    setTimeout(() => appendLog('INFO', 'WAR artifact located in workspace', 'lvl-info'), 500);
    setTimeout(() => appendLog('INFO', 'Deploying to Tomcat webapps/', 'lvl-info'), 1100);
    setTimeout(() => appendLog('OK  ', 'Deployment successful — context reloaded', 'lvl-ok'), 2000);
  }

  function sendStdin() {
    const inp = document.getElementById('stdinInput');
    const val = inp.value.trim();
    if (!val) return;
    appendLog('>   ', val, 'lvl-warn');
    inp.value = '';
    setTimeout(() => appendLog('INFO', 'stdin received by process', 'lvl-info'), 200);
  }

  document.getElementById('stdinInput').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') sendStdin();
  });

  // live clock in cursor row
  setInterval(() => {
    const t = document.getElementById('livetime');
    if (t) t.textContent = ts();
  }, 1000);
</script>
</body>
</html>

