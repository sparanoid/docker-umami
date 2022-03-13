ARG BASE_TAG=postgresql-latest

# FROM php:7.4-fpm-alpine # alpine does not work with pecl extensions for the lack of glibc
FROM ghcr.io/mikecao/umami:${BASE_TAG}

LABEL maintainer "Tunghsiao Liu <t@sparanoid.com>"
