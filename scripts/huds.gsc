spawnClientShader(shader, point, relativePoint, x, y, width, height, color, alpha, sort) {
	elem = createIcon(shader, width, height);
	elem setPoint(point, relativePoint, x, y);
	elem.color = color;
	elem.alpha = alpha;
	elem.sort = sort;
	
	return elem;
}

spawnServerText(font, text, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort, team) {
	elem = createServerFontString(font, fontScale, team);
	elem setPoint(point, relativePoint, x, y);
	elem setText(text);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
	elem.sort = sort;
	
	return elem;
}