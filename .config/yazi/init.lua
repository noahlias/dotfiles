function Linemode:custom()
	local year = os.date("%Y")
	local time = (self._file.cha.modified or 0) // 1

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%b %d %H:%M", time)
	else
		time = time and os.date("%b %d  %Y", time) or ""
	end

	local size = self._file:size()
	return ui.Line(string.format(" %s %s ", size and ya.readable_size(size):gsub(" ", "") or "-", time))
end

-- function Status:owner()
-- 	local h = self._tab.current.hovered
-- 	if not h then
-- 		return ui.Line({})
-- 	end
-- 	return ui.Line({
-- 		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("green"),
-- 		ui.Span(":"),
-- 		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
-- 		ui.Span(" "),
-- 	})
-- end
--
-- function Status:render()
-- 	local left = self:children_render(self.LEFT)
-- 	local right = ui.Line({ self:owner(), self:children_render(self.RIGHT) })
-- 	return {
-- 		ui.Paragraph(self._area, { left }),
-- 		ui.Paragraph(self._area, { right }):align(ui.Paragraph.RIGHT),
-- 		table.unpack(Progress:render(self._area, right:width())),
-- 	}
-- end

require("zoxide"):setup({
	update_db = true,
})
require("full-border"):setup()
require("starship"):setup()
