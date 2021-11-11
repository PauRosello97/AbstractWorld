#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform sampler2D agentList;
uniform uint agentCount;
uniform int maxAgents;
uniform int nAgents;

// From: https://gist.github.com/yiwenl/745bfea7f04c456e0101
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec3 c = vec3(0.);
    
		    
    for(int i=0; i<nAgents; i++){
        vec4 agent = texture2D(agentList, vec2(0, i/float(maxAgents)));
        vec2 aP = vec2(agent.r, agent.g);
        float hue = agent.b;
        vec3 aC = hsv2rgb(vec3(hue, 1., 1.));

        float d = distance(aP, position)*10.;
        //if(d<0.1) c = aC;
        
        c = mix(c,aC,d);
    }
	
	gl_FragColor = vec4(c, 1.);

}