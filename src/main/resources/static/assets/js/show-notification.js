// Função para criar o HTML da notificação de sucesso
function createSuccessNotificationHTML(message) {
    return `
        <div class="alert alert-success d-flex align-items-center" role="alert" style="color: white; display:none; position: fixed; top: -100px; left: 50%; transform: translateX(-50%); z-index: 9999;">
            <svg width="24" height="24" fill="currentColor">
                <!-- SVG content -->
            </svg>
            <div>
                <span class="message">${message}</span>
            </div>
            <button type="button" class="btn-close" aria-label="Close"></button>
        </div>
    `;
}

// Função para criar o HTML da notificação de erro
function createErrorNotificationHTML(message) {
    return `
        <div class="alert alert-danger d-flex align-items-center" role="alert" style="color: white; display:none; position: fixed; top: -100px; left: 50%; transform: translateX(-50%); z-index: 9999;">
            <svg width="24" height="24" fill="currentColor">
                <!-- SVG content -->
            </svg>
            <div>
                <span class="message">${message}</span>
            </div>
            <button type="button" class="btn-close" aria-label="Close"></button>
        </div>
    `;
}

// Função para mostrar notificações
function showToastNotification(message, type) {
    let notificationHTML;

    if (type === 'success') {
        notificationHTML = createSuccessNotificationHTML(message);
    } else {
        notificationHTML = createErrorNotificationHTML(message);
    }

    const $notificationElement = $(notificationHTML);

    // Adicionando evento de clique ao botão de fechar
    $notificationElement.find('.btn-close').on('click', function() {
        $notificationElement.animate({ 'opacity': 0, 'top': '-100px' }, 500, function() {
            $(this).remove();
        });
    });

    // Inserindo no DOM
    $('body').append($notificationElement);

    // Mostrar a notificação
    $notificationElement.show().animate({ 'opacity': 1, 'top': '15px' }, 500);

    // Ocultar a notificação após 5 segundos
    setTimeout(function() {
        $notificationElement.animate({ 'opacity': 0, 'top': '-100px' }, 500, function() {
            $(this).remove();
        });
    }, 5000);
}
