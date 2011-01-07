$(function() {
    if (!$("html").is(".canvas")) {
        return;
    }
    
    var 
        count = 20,
    
        prng = function() {
            return Math.ceil(
                arguments.length == 1 ?
                    Math.random() * arguments[0] :
                    Math.random() * (arguments[1] - arguments[0]) + arguments[0]
            );
        },
    
        renderWidth = $("body")[0].clientWidth,
        renderHeight = $("body")[0].clientHeight,
    
        $canv = $("<canvas/>")
            .attr("width", renderWidth)
            .attr("height", renderHeight)
            .attr("id", "arrowCanvas")
            .appendTo("body"),
        ctx = $canv[0].getContext("2d"),
        
        pid = -1,
        
        lastDraw = null,
        
        dt = 100,
        
        colors = [ "black", "#444", "#133CAC" ],
        
        Arrow = function(offscreen) {
            this.direction = Math.random() > 0.5 ? 1 : -1;
          
            this.color = colors[prng(colors.length)];
            this.width = prng(100, 200);
            this.height = prng(10, 20) * 2;
            this.thickness = prng(1, 4)
            
            if (offscreen) {
                this.left = this.direction == 1 ?
                    -this.width :
                    renderWidth;
            }
            else {
                this.left = prng(renderWidth);
            }
            
            this.top = prng(renderHeight);
            this.speed = prng(5, 20);
            
            
            this.update = function(diff) {
                this.left += Math.ceil(this.speed * diff) * this.direction;
            };
        },
        
        arrows = [];
        
    for (var idx = 0; idx < count; ++idx) {
        arrows.push(new Arrow());
    }
        
    lastDraw = new Date();
    pid = setInterval(
        function() {
            ctx.clearRect(
                0,
                0,
                renderWidth,
                renderHeight
            );
            
            var
                diff = new Date(new Date() - lastDraw).getMilliseconds() / 1000;
                
            lastDraw = new Date();
        
        
            for (var idx = 0; idx < count; ++idx) {
                var 
                    arrow = arrows[idx];
                
                arrow.update(diff);

                if (arrow.left > renderWidth || arrow.left + arrow.width < 0) {
                    arrows[idx] = new Arrow(true);
                }
                
                ctx.fillStyle = arrow.color;
                ctx.strokeStyle = arrow.color;
                ctx.lineWidth = arrow.thickness;
                
                ctx.fillRect(
                    arrow.left, 
                    arrow.top + 0.5 * Math.floor(arrow.height - arrow.thickness),
                    arrow.width,
                    arrow.thickness
                );
                
                if (arrow.direction == 1) {
                    ctx.beginPath();
                    ctx.moveTo(
                        arrow.left + arrow.width - 0.5 * arrow.height, 
                        arrow.top
                    );
                    ctx.lineTo(
                        arrow.left + arrow.width,
                        arrow.top + 0.5 * arrow.height
                    );
                    ctx.lineTo(
                        arrow.left + arrow.width - 0.5 * arrow.height, 
                        arrow.top + arrow.height
                    );
                    ctx.stroke();
                }
                else {
                    ctx.beginPath();
                    ctx.moveTo(
                        arrow.left + 0.5 * arrow.height, 
                        arrow.top
                    );
                    ctx.lineTo(
                        arrow.left,
                        arrow.top + 0.5 * arrow.height
                    );
                    ctx.lineTo(
                        arrow.left + 0.5 * arrow.height, 
                        arrow.top + arrow.height
                    );
                    ctx.stroke();
                }
                
            }
        },
        dt
    );
    
    
});
