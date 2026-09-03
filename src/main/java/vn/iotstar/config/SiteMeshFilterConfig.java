package vn.iotstar.config;

import jakarta.servlet.annotation.WebFilter;

import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*")
public class SiteMeshFilterConfig
        extends ConfigurableSiteMeshFilter {
}