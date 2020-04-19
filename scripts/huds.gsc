spawnClientShader(shader, point, relativePoint, x, y, width, height, color, alpha, sort) {
	elem = createIcon(shader, width, height);
	elem setPoint(point, relativePoint, x, y);
	elem.color = color;
	elem.alpha = alpha;
	elem.sort = sort;
	
	return elem;
}

spawnServerShader(shader, point, relativePoint, x, y, width, height, color, alpha, sort, team) {
	elem = createServerIcon(shader, width, height, team);
	elem setPoint(point, relativePoint, x, y);
	elem.color = color;
	elem.alpha = alpha;
	elem.sort = sort;
	
	return elem;
}

spawnClientText(font, text, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort) {
	elem = createFontString(font, fontScale);
	elem setPoint(point, relativePoint, x, y);
	elem setText(text);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
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

spawnClientValue(font, value, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort) {
	elem = createFontString(font, fontScale);
	elem setPoint(point, relativePoint, x, y);
	elem setValue(value);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
	elem.sort = sort;
	
	return elem;
}

spawnServerValue(font, value, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort, team) {
	elem = createServerFontString(font, fontScale);
	elem setPoint(point, relativePoint, x, y);
	elem setValue(value);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
	elem.sort = sort;
	
	return elem;
}

spawnClientTimer(font, value, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort) {
	elem = createClientTimer(font, fontScale);
	elem setPoint(point, relativePoint, x, y);
	elem setTimer(value);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
	elem.sort = sort;

	return elem;
}

spawnServerTimer(font, value, fontScale, point, relativePoint, x, y, color, glowColor, alpha, glowAlpha, sort, team) {
	elem = createServerTimer(font, fontScale, team);
	elem setPoint(point, relativePoint, x, y);
	elem setTimer(value);
	elem.color = color;
	elem.glowColor = glowColor;
	elem.alpha = alpha;
	elem.glowAlpha = glowAlpha;
	elem.sort = sort;

	return elem;
}