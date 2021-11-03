#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform int[] points;

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	
	vec3 color = vec3(position.x, position.y, 0.2);
	gl_FragColor = vec4(color, 1.0);

}