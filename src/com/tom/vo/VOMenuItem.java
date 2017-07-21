package com.tom.vo;

public class VOMenuItem {
	private int parentid;
	private String menuItemTitle;
	private String menuItemIcon;
	private String menuItemUrl;
	private String privelegeCode;

	public VOMenuItem(int parentid, String menuItemTitle, String menuItemIcon,
			String menuItemUrl, String privelegeCode) {
		this.parentid = parentid;
		this.menuItemTitle = menuItemTitle;
		this.menuItemIcon = menuItemIcon;
		this.menuItemUrl = menuItemUrl;
		this.privelegeCode = privelegeCode;
	}

	public int getParentid() {
		return this.parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public String getMenuItemTitle() {
		return this.menuItemTitle;
	}

	public void setMenuItemTitle(String menuItemTitle) {
		this.menuItemTitle = menuItemTitle;
	}

	public String getMenuItemIcon() {
		return this.menuItemIcon;
	}

	public void setMenuItemIcon(String menuItemIcon) {
		this.menuItemIcon = menuItemIcon;
	}

	public String getMenuItemUrl() {
		return this.menuItemUrl;
	}

	public void setMenuItemUrl(String menuItemUrl) {
		this.menuItemUrl = menuItemUrl;
	}

	public String getPrivelegeCode() {
		return this.privelegeCode;
	}

	public void setPrivelegeCode(String privelegeCode) {
		this.privelegeCode = privelegeCode;
	}
}