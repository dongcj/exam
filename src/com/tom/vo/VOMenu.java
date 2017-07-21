package com.tom.vo;

import java.util.List;

public class VOMenu {
	private int mid;
	private String menuTitle;
	private List<VOMenuItem> menuItems;
	private String privelegeCode;
	private String group;

	public VOMenu(int mid, String menuTitle, List<VOMenuItem> menuItems,
			String privelegeCode) {
		this.mid = mid;
		this.menuTitle = menuTitle;
		this.menuItems = menuItems;
		this.privelegeCode = privelegeCode;
	}

	public VOMenu(int mid, String menuTitle, List<VOMenuItem> menuItems,
			String privelegeCode, String group) {
		this.mid = mid;
		this.menuTitle = menuTitle;
		this.menuItems = menuItems;
		this.privelegeCode = privelegeCode;
		this.group = group;
	}

	public String getGroup() {
		return this.group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public int getMid() {
		return this.mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getMenuTitle() {
		return this.menuTitle;
	}

	public void setMenuTitle(String menuTitle) {
		this.menuTitle = menuTitle;
	}

	public List<VOMenuItem> getMenuItems() {
		return this.menuItems;
	}

	public void setMenuItems(List<VOMenuItem> menuItems) {
		this.menuItems = menuItems;
	}

	public String getPrivelegeCode() {
		return this.privelegeCode;
	}

	public void setPrivelegeCode(String privelegeCode) {
		this.privelegeCode = privelegeCode;
	}
}