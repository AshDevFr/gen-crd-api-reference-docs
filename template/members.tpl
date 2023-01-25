{{ define "members" }}

{{ range .Members }}
{{ if not (hiddenMember .)}}
<tr>
    <td>
        <code>{{ fieldName . }}</code><br/>
        <em>
            {{ if linkForType .Type }}
                <a href="{{ linkForType .Type}}">
                    {{ typeDisplayName .Type }}
                </a>
            {{ else }}
                {{ typeDisplayName .Type }}
            {{ end }}
        </em>
    </td>
    <td>
        {{ if fieldEmbedded . }}
            <p>
                (Members of <code>{{ fieldName . }}</code> are embedded into this type.)
            </p>
        {{ end}}

        {{ safe (renderComments .CommentLines) }}

        {{ if isOptionalMember .}}
            <em>(Optional)</em>
        {{ end }}

        {{ if isNullableMember . }}
            <em>(Nullable)</em>
        {{ end }}

        {{ if defaultMemberValue . }}
            <p>Default: {{defaultMemberValue .}}</p>
        {{ end }}

        {{ if hasMemberValidations . }}
            <p><b>Validations:</b>
                {{range $k, $v := (memberValidations .)}}
                    <br/><i>{{$k}}: </i>{{$v}}
                {{end}}
            </p>
        {{ end }}

    {{ if and (eq (.Type.Name.Name) "ObjectMeta") }}
        Refer to the Kubernetes API documentation for the fields of the
        <code>metadata</code> field.
    {{ end }}

    {{ if or (eq (fieldName .) "spec") }}
        <br/>
        <br/>
        <table>
            {{ template "members" .Type }}
        </table>
    {{ end }}
    </td>
</tr>
{{ end }}
{{ end }}

{{ end }}
