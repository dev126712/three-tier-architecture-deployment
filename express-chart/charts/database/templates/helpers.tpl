{{/* Define the name of the chart */}}
{{- define "database.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Define a fully qualified app name */}}
{{- define "database.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Define the service account name to use */}}
{{- define "database.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "database.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* Selector labels */}}
{{- define "database.selectorLabels" -}}
app.kubernetes.io/name: {{ include "database.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
