+++
title = "React"
date = "2017-01-04T09:05:10Z"
tags = ["React", "Front End", "JavaScript"]
+++

I'm using react for the first time.
<!--more-->
~~~JavaScript
var ToDo = React.createClass({
    render: function() {
        return (<li>{this.props.taskName}</li>);
    }
});

ReactDOM.render( 
    <h1>ToDo App</h1>
    <ToDo taskName="Write blog post about JavaScript"/>,
    document.getElementById("container")
);
~~~

Seeing these inline templates along with the code seems strangely familiar.

~~~PHP
<?php
$time = sprintf('%.4f', ($t2 - $t1) );
$production = true;
?>
<div style="border: 1px blue;">
    <form>
        <input value="<?php echo $time; ?>" />
    </form>
</div>
~~~

Rasmus Lerdorf would be proud...