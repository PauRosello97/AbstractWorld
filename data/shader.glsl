#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform sampler2D agentList;
uniform uint agentCount;

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec4 c = vec4(0., 0., 0., 1.);

    //for(int i=0; i<agentCount; i++){
		    
    for(int i=0; i<20; i++){
        vec4 agent = texture2D(agentList, vec2(0, i));
        vec2 aP = vec2(agent.r, agent.g);
        if(distance(aP, position)<0.01) c += vec4(1., 0., 0., 1.);
    }
	
	gl_FragColor = vec4(c);

}